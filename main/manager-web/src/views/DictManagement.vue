<template>
    <div class="welcome">
        <HeaderBar />

        <div class="operation-bar">
            <h2 class="page-title">Dictionary Management</h2>
            <div class="action-group">
                <div class="search-group">
                    <el-input placeholder="Enter dictionary label to search" v-model="search" class="search-input" clearable
                        @keyup.enter.native="handleSearch" style="width: 240px" />
                    <el-button class="btn-search" @click="handleSearch">
                        Search
                    </el-button>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="main-wrapper">
            <div class="content-panel">
                <!-- Dictionary Type List (Left Side) -->
                <div class="dict-type-panel">
                    <div class="dict-type-header">
                        <el-button type="success" size="mini" @click="showAddDictTypeDialog">Add Dictionary Type</el-button>
                        <el-button type="danger" size="mini" @click="batchDeleteDictType"
                            :disabled="selectedDictTypes.length === 0">
                            Batch Delete Types
                        </el-button>
                    </div>
                    <el-table ref="dictTypeTable" :data="dictTypeList" style="width: 100%" v-loading="dictTypeLoading"
                        element-loading-text="Loading..." element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(255, 255, 255, 0.7)" @row-click="handleDictTypeRowClick"
                        @selection-change="handleDictTypeSelectionChange" :row-class-name="tableRowClassName"
                        class="dict-type-table">
                        <el-table-column type="selection" width="55" align="center"></el-table-column>
                        <el-table-column label="Dictionary Type Name" prop="dictName" align="center"></el-table-column>
                        <el-table-column label="Actions" width="100" align="center">
                            <template slot-scope="scope">
                                <el-button type="text" size="mini" @click.stop="editDictType(scope.row)">Edit</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>

                <!-- Dictionary Data List (Right Side) -->
                <div class="content-area">
                    <el-card class="dict-data-card" shadow="never">
                        <el-table ref="dictDataTable" :data="dictDataList" style="width: 100%"
                            v-loading="dictDataLoading" element-loading-text="Loading..."
                            element-loading-spinner="el-icon-loading"
                            element-loading-background="rgba(255, 255, 255, 0.7)" class="data-table"
                            header-row-class-name="table-header">
                            <el-table-column label="Select" align="center" width="55">
                                <template slot-scope="scope">
                                    <el-checkbox v-model="scope.row.selected"></el-checkbox>
                                </template>
                            </el-table-column>
                            <el-table-column label="Dictionary Label" prop="dictLabel" align="center"></el-table-column>
                            <el-table-column label="Dictionary Value" prop="dictValue" align="center"></el-table-column>
                            <el-table-column label="Sort" prop="sort" align="center"></el-table-column>
                            <el-table-column label="Actions" align="center" width="180px">
                                <template slot-scope="scope">
                                    <el-button type="text" size="mini" @click="editDictData(scope.row)"
                                        class="edit-btn">
                                        Edit
                                    </el-button>
                                    <el-button type="text" size="mini" @click="deleteDictData(scope.row)"
                                        class="delete-btn">
                                        Delete
                                    </el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <div class="table-footer">
                            <div class="batch-actions">
                                <el-button size="mini" type="primary" @click="selectAllDictData">
                                    {{ isAllDictDataSelected ? 'Deselect All' : 'Select All' }}
                                </el-button>
                                <el-button type="success" size="mini" @click="showAddDictDataDialog" class="add-btn">
                                    Add Dictionary Data
                                </el-button>
                                <el-button size="mini" type="danger" icon="el-icon-delete" @click="batchDeleteDictData">
                                    Batch Delete Data
                                </el-button>
                            </div>
                            <div class="custom-pagination">
                                <el-select v-model="pageSize" @change="handlePageSizeChange" class="page-size-select">
                                    <el-option v-for="item in pageSizeOptions" :key="item" :label="`${item} items/page`"
                                        :value="item">
                                    </el-option>
                                </el-select>

                                <button class="pagination-btn" :disabled="currentPage === 1" @click="goFirst">
                                    First
                                </button>
                                <button class="pagination-btn" :disabled="currentPage === 1" @click="goPrev">
                                    Previous
                                </button>
                                <button v-for="page in visiblePages" :key="page" class="pagination-btn"
                                    :class="{ active: page === currentPage }" @click="goToPage(page)">
                                    {{ page }}
                                </button>
                                <button class="pagination-btn" :disabled="currentPage === pageCount" @click="goNext">
                                    Next
                                </button>
                                <span class="total-text">Total: {{ total }} records</span>
                            </div>
                        </div>
                    </el-card>
                </div>
            </div>
        </div>

        <!-- Dictionary Type Edit Dialog Component -->
        <DictTypeDialog :visible.sync="dictTypeDialogVisible" :title="dictTypeDialogTitle" :dictTypeData="dictTypeForm"
            @save="saveDictType" />

        <!-- Dictionary Data Edit Dialog Component -->
        <DictDataDialog :visible.sync="dictDataDialogVisible" :title="dictDataDialogTitle" :dictData="dictDataForm"
            :dictTypeId="selectedDictType?.id" @save="saveDictData" />
        <el-footer style="flex-shrink:unset;">
            <version-footer />
        </el-footer>
    </div>
</template>

<script>
import dictApi from '@/apis/module/dict'
import DictDataDialog from '@/components/DictDataDialog.vue'
import DictTypeDialog from '@/components/DictTypeDialog.vue'
import HeaderBar from '@/components/HeaderBar.vue'
import VersionFooter from '@/components/VersionFooter.vue'
export default {
    name: 'DictManagement',
    components: {
        HeaderBar,
        DictTypeDialog,
        DictDataDialog,
        VersionFooter
    },
    data() {
        return {
            // Dictionary type related
            dictTypeList: [],
            dictTypeLoading: false,
            selectedDictType: null,
            selectedDictTypes: [],  // Multiple selection array
            dictTypeDialogVisible: false,
            dictTypeDialogTitle: 'Add Dictionary Type',
            dictTypeForm: {
                id: null,
                dictName: '',
                dictType: ''
            },

            // Dictionary data related
            dictDataList: [],
            dictDataLoading: false,
            isAllDictDataSelected: false,
            dictDataDialogVisible: false,
            dictDataDialogTitle: 'Add Dictionary Data',
            dictDataForm: {
                id: null,
                dictTypeId: null,
                dictLabel: '',
                dictValue: '',
                sort: 0
            },
            search: '',
            // Pagination related data
            pageSizeOptions: [10, 20, 50, 100],
            currentPage: 1,
            pageSize: 10,
            total: 0
        }
    },
    created() {
        this.loadDictTypeList()
    },
    methods: {
        // Dictionary type related methods
        loadDictTypeList() {
            this.dictTypeLoading = true
            dictApi.getDictTypeList({
                page: 1,
                limit: 100,
                dictName: this.search
            }, ({ data }) => {
                if (data.code === 0) {
                    this.dictTypeList = data.data.list
                    if (this.dictTypeList.length > 0) {
                        this.selectedDictType = this.dictTypeList[0]
                        this.loadDictDataList(this.dictTypeList[0].id)
                        this.$nextTick(() => {
                            this.$refs.dictTypeTable.setCurrentRow(this.dictTypeList[0])
                        })
                    }
                }
                this.dictTypeLoading = false
            })
        },
        handleDictTypeRowClick(row) {
            this.selectedDictType = row
            this.loadDictDataList(row.id)
            this.$refs.dictTypeTable.setCurrentRow(row)
        },
        handleDictTypeSelectionChange(val) {
            this.selectedDictTypes = val
        },
        tableRowClassName({ row }) {
            return row === this.selectedDictType ? 'current-row' : ''
        },
        showAddDictTypeDialog() {
            this.dictTypeDialogTitle = 'Add Dictionary Type'
            this.dictTypeForm = {
                id: null,
                dictName: '',
                dictType: ''
            }
            this.dictTypeDialogVisible = true
        },
        editDictType(row) {
            this.dictTypeDialogTitle = 'Edit Dictionary Type'
            this.dictTypeForm = { ...row }
            this.dictTypeDialogVisible = true
        },
        saveDictType(formData) {
            const api = formData.id ? dictApi.updateDictType : dictApi.addDictType
            api(formData, ({ data }) => {
                if (data.code === 0) {
                    this.$message.success('Saved successfully')
                    this.dictTypeDialogVisible = false
                    this.loadDictTypeList()
                }
            })
        },
        batchDeleteDictType() {
            if (this.selectedDictTypes.length === 0) {
                this.$message.warning('Please select dictionary types to delete')
                return
            }

            this.$confirm('Are you sure you want to delete the selected dictionary types?', 'Warning', {
                confirmButtonText: 'Confirm',
                cancelButtonText: 'Cancel',
                type: 'warning'
            }).then(() => {
                const ids = this.selectedDictTypes.map(item => item.id)
                dictApi.deleteDictType(ids, ({ data }) => {
                    if (data.code === 0) {
                        this.$message.success('Deleted successfully')
                        this.loadDictTypeList()
                    }
                })
            })
        },

        // Dictionary data related methods
        loadDictDataList(dictTypeId) {
            if (!dictTypeId) return
            this.dictDataLoading = true
            dictApi.getDictDataList({
                dictTypeId,
                page: this.currentPage,
                limit: this.pageSize,
                dictLabel: this.search,
                dictValue: ''
            }, ({ data }) => {
                if (data.code === 0) {
                    this.dictDataList = data.data.list.map(item => ({
                        ...item,
                        selected: false
                    }))
                    this.total = data.data.total
                } else {
                    this.$message.error(data.msg || 'Failed to get dictionary data')
                }
                this.dictDataLoading = false
            })
        },
        selectAllDictData() {
            this.isAllDictDataSelected = !this.isAllDictDataSelected
            this.dictDataList.forEach(row => {
                row.selected = this.isAllDictDataSelected
            })
        },
        showAddDictDataDialog() {
            if (!this.selectedDictType) {
                this.$message.warning('Please select a dictionary type first')
                return
            }
            this.dictDataDialogTitle = 'Add Dictionary Data'
            this.dictDataForm = {
                id: null,
                dictTypeId: this.selectedDictType.id,
                dictLabel: '',
                dictValue: '',
                sort: 0
            }
            this.dictDataDialogVisible = true
        },
        editDictData(row) {
            this.dictDataDialogTitle = 'Edit Dictionary Data'
            this.dictDataForm = { ...row }
            this.dictDataDialogVisible = true
        },
        saveDictData(formData) {
            const api = formData.id ? dictApi.updateDictData : dictApi.addDictData
            api(formData, ({ data }) => {
                if (data.code === 0) {
                    this.$message.success('Saved successfully')
                    this.dictDataDialogVisible = false
                    this.loadDictDataList(formData.dictTypeId)
                }
            })
        },
        deleteDictData(row) {
            this.$confirm('Are you sure you want to delete this dictionary data?', 'Warning', {
                confirmButtonText: 'Confirm',
                cancelButtonText: 'Cancel',
                type: 'warning'
            }).then(() => {
                dictApi.deleteDictData([row.id], ({ data }) => {
                    if (data.code === 0) {
                        this.$message.success('Deleted successfully')
                        this.loadDictDataList(row.dictTypeId)
                    }
                })
            })
        },
        batchDeleteDictData() {
            const selectedRows = this.dictDataList.filter(row => row.selected)
            if (selectedRows.length === 0) {
                this.$message.warning('Please select dictionary data to delete')
                return
            }

            this.$confirm(`Are you sure you want to delete the selected ${selectedRows.length} dictionary data items?`, 'Warning', {
                confirmButtonText: 'Confirm',
                cancelButtonText: 'Cancel',
                type: 'warning'
            }).then(() => {
                const ids = selectedRows.map(item => item.id)
                dictApi.deleteDictData(ids, ({ data }) => {
                    if (data.code === 0) {
                        this.$message.success('Deleted successfully')
                        this.loadDictDataList(this.selectedDictType.id)
                    }
                })
            })
        },
        handleSearch() {
            if (!this.selectedDictType) {
                this.$message.warning('Please select a dictionary type first')
                return
            }
            this.currentPage = 1
            this.loadDictDataList(this.selectedDictType.id)
        },
        // Pagination related methods
        handlePageSizeChange(val) {
            this.pageSize = val;
            this.currentPage = 1;
            this.loadDictDataList(this.selectedDictType?.id);
        },
        goFirst() {
            this.currentPage = 1;
            this.loadDictDataList(this.selectedDictType?.id);
        },
        goPrev() {
            if (this.currentPage > 1) {
                this.currentPage--;
                this.loadDictDataList(this.selectedDictType?.id);
            }
        },
        goNext() {
            if (this.currentPage < this.pageCount) {
                this.currentPage++;
                this.loadDictDataList(this.selectedDictType?.id);
            }
        },
        goToPage(page) {
            this.currentPage = page;
            this.loadDictDataList(this.selectedDictType?.id);
        }
    },
    computed: {
        pageCount() {
            return Math.ceil(this.total / this.pageSize);
        },
        visiblePages() {
            const pages = [];
            const maxVisible = 3;
            let start = Math.max(1, this.currentPage - 1);
            let end = Math.min(this.pageCount, start + maxVisible - 1);

            if (end - start + 1 < maxVisible) {
                start = Math.max(1, end - maxVisible + 1);
            }

            for (let i = start; i <= end; i++) {
                pages.push(i);
            }
            return pages;
        }
    }
}
</script>

<style lang="scss" scoped>
.welcome {
    min-width: 900px;
    min-height: 506px;
    height: 100vh;
    display: flex;
    position: relative;
    flex-direction: column;
    background-size: cover;
    background: linear-gradient(to bottom right, #dce8ff, #e4eeff, #e6cbfd) center;
    -webkit-background-size: cover;
    -o-background-size: cover;
    overflow: hidden;
}

.main-wrapper {
    margin: 5px 22px;
    border-radius: 15px;
    min-height: calc(100vh - 24vh);
    height: auto;
    max-height: 80vh;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    position: relative;
    background: rgba(237, 242, 255, 0.5);
    display: flex;
    flex-direction: column;
}

.operation-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px 24px;
}

.page-title {
    font-size: 24px;
    margin: 0;
}

.action-group {
    display: flex;
    align-items: center;
    gap: 16px;
}

.search-group {
    display: flex;
    gap: 10px;
}

.search-input {
    width: 240px;
}

.btn-search {
    background: linear-gradient(135deg, #6b8cff, #a966ff);
    border: none;
    color: white;
}

.btn-search:hover {
    opacity: 0.9;
    transform: translateY(-1px);
}

:deep(.search-input .el-input__inner) {
    border-radius: 4px;
    border: 1px solid #DCDFE6;
    background-color: white;
    transition: border-color 0.2s;
}

:deep(.search-input .el-input__inner:focus) {
    border-color: #6b8cff;
    outline: none;
}

.content-panel {
    flex: 1;
    display: flex;
    overflow: hidden;
    height: 100%;
    border-radius: 15px;
    background: transparent;
    border: 1px solid #fff;
}

.dict-type-panel {
    width: 300px;
    background: white;
    border-right: 1px solid #ebeef5;
    display: flex;
    flex-direction: column;
}

.dict-type-header {
    padding: 16px;
    border-bottom: 1px solid #ebeef5;
    display: flex;
    gap: 8px;
}

.dict-type-table {
    flex: 1;
    overflow-y: auto;
}

.content-area {
    flex: 1;
    padding: 24px;
    height: 100%;
    min-width: 600px;
    overflow: hidden;
    background-color: white;
    display: flex;
    flex-direction: column;
}

.dict-data-card {
    background: white;
    flex: 1;
    display: flex;
    flex-direction: column;
    border: none;
    box-shadow: none;
    overflow: hidden;
}

.data-table {
    border-radius: 6px;
    overflow-y: hidden;
    background-color: transparent !important;
    --table-max-height: calc(100vh - 40vh);
    max-height: var(--table-max-height);

    :deep(.el-table__body-wrapper) {
        max-height: calc(var(--table-max-height) - 40px);
        overflow-y: auto;
    }

    :deep(.el-table__body) {
        tr:last-child td {
            border-bottom: none;
        }
    }
}

:deep(.el-table) {
    &::before {
        display: none;
    }

    &::after {
        display: none;
    }
}

.table-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px 0;
    width: 100%;
    flex-shrink: 0;
    min-height: 60px;
    background: white;
    margin-top: 10px;
}

.batch-actions {
    display: flex;
    gap: 8px;
    padding-left: 26px;

    .el-button {
        min-width: 72px;
        height: 32px;
        padding: 7px 12px 7px 10px;
        font-size: 12px;
        border-radius: 4px;
        line-height: 1;
        font-weight: 500;
        border: none;
        transition: all 0.3s ease;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);

        &:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
    }

    .el-button--primary {
        background: #5f70f3;
        color: white;
    }

    .el-button--success {
        background: #5bc98c;
        color: white;
    }

    .el-button--danger {
        background: #fd5b63;
        color: white;
    }
}

.custom-pagination {
    display: flex;
    align-items: center;
    gap: 8px;

    .el-select {
        margin-right: 8px;
    }

    .pagination-btn:first-child,
    .pagination-btn:nth-child(2),
    .pagination-btn:nth-child(3),
    .pagination-btn:nth-last-child(2) {
        min-width: 60px;
        height: 32px;
        padding: 0 12px;
        border-radius: 4px;
        border: 1px solid #e4e7ed;
        background: #dee7ff;
        color: #606266;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s ease;

        &:hover {
            background: #d7dce6;
        }

        &:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
    }

    .pagination-btn:not(:first-child):not(:nth-child(2)):not(:nth-child(3)):not(:nth-last-child(2)) {
        min-width: 28px;
        height: 32px;
        padding: 0;
        border-radius: 4px;
        border: 1px solid transparent;
        background: transparent;
        color: #606266;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s ease;

        &:hover {
            background: rgba(245, 247, 250, 0.3);
        }
    }

    .pagination-btn.active {
        background: #5f70f3 !important;
        color: #ffffff !important;
        border-color: #5f70f3 !important;

        &:hover {
            background: #6d7cf5 !important;
        }
    }

    .total-text {
        color: #909399;
        font-size: 14px;
        margin-left: 10px;
    }
}

.page-size-select {
    width: 100px;
    margin-right: 10px;

    :deep(.el-input__inner) {
        height: 32px;
        line-height: 32px;
        border-radius: 4px;
        border: 1px solid #e4e7ed;
        background: #dee7ff;
        color: #606266;
        font-size: 14px;
    }

    :deep(.el-input__suffix) {
        right: 6px;
        width: 15px;
        height: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        top: 6px;
        border-radius: 4px;
    }

    :deep(.el-input__suffix-inner) {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
    }

    :deep(.el-icon-arrow-up:before) {
        content: "";
        display: inline-block;
        border-left: 6px solid transparent;
        border-right: 6px solid transparent;
        border-top: 9px solid #606266;
        position: relative;
        transform: rotate(0deg);
        transition: transform 0.3s;
    }
}

.edit-btn,
.delete-btn {
    margin: 0 8px;
    color: #7079aa !important;
    font-size: 12px;
    padding: 7px 12px;
    height: 32px;
    line-height: 1;
    border-radius: 4px;
    transition: all 0.3s ease;

    &:hover {
        color: #5a64b5 !important;
        transform: translateY(-1px);
    }
}

:deep(.dict-type-header .el-button) {
    min-width: 72px;
    height: 32px;
    padding: 7px 12px 7px 10px;
    font-size: 12px;
    border-radius: 4px;
    line-height: 1;
    font-weight: 500;
    border: none;
    transition: all 0.3s ease;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);

    &:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    }

    &.el-button--success {
        background: #5bc98c;
        color: white;
    }

    &.el-button--danger {
        background: #fd5b63;
        color: white;
    }
}

:deep(.el-table .cell) {
    padding-left: 10px;
    padding-right: 10px;
}

:deep(.el-loading-mask) {
    background-color: rgba(255, 255, 255, 0.6) !important;
    backdrop-filter: blur(2px);
}

:deep(.el-loading-spinner .circular) {
    width: 28px;
    height: 28px;
}

:deep(.el-loading-spinner .path) {
    stroke: #6b8cff;
}

:deep(.el-loading-text) {
    color: #6b8cff !important;
    font-size: 14px;
    margin-top: 8px;
}

:deep(.dict-type-table .el-table__row) {
    cursor: pointer;
}

:deep(.dict-type-table .el-table__row.current-row) {
    background-color: #5778ff !important;
    color: white;
}

:deep(.dict-type-table .el-table__row.current-row .el-button--text) {
    color: white !important;
}

:deep(.dict-type-table .el-table__row:hover) {
    background-color: #f5f7fa;
}

:deep(.dict-type-table .el-table__row.current-row:hover) {
    background-color: #5778ff !important;
}

:deep(.dict-type-table .el-table__row td) {
    background-color: transparent !important;
}

:deep(.el-table thead) {
    color: #000000;
}

:deep(.el-card__body) {
    padding: 15px;
    display: flex;
    flex-direction: column;
    flex: 1;
    overflow: hidden;
}

:deep(.el-checkbox__inner) {
    background-color: #eeeeee !important;
    border-color: #cccccc !important;
}

:deep(.el-checkbox__inner:hover) {
    border-color: #cccccc !important;
}

:deep(.el-checkbox__input.is-checked .el-checkbox__inner) {
    background-color: #5f70f3 !important;
    border-color: #5f70f3 !important;
}
</style>