<template>
  <el-dialog
    :title="title"
    :visible.sync="dialogVisible"
    width="500px"
    :close-on-click-modal="false"
    :close-on-press-escape="false"
    :show-close="false"
    class="param-dialog"
    @close="handleClose"
  >
    <div class="dialog-content">
      <el-form :model="form" :rules="rules" ref="form" label-width="110px" label-position="left" class="param-form">
        <el-form-item label="Parameter Code" prop="paramCode" class="form-item">
          <el-input v-model="form.paramCode" placeholder="Enter parameter code" class="custom-input"></el-input>
        </el-form-item>

        <el-form-item label="Parameter Value" prop="paramValue" class="form-item">
          <el-input v-model="form.paramValue" placeholder="Enter parameter value" class="custom-input"></el-input>
        </el-form-item>

        <el-form-item label="Value Type" prop="valueType" class="form-item">
          <el-select v-model="form.valueType" placeholder="Select value type" class="custom-select">
            <el-option v-for="item in valueTypeOptions" :key="item.value" :label="item.label" :value="item.value"/>
          </el-select>
        </el-form-item>

        <el-form-item label="Remarks" prop="remark" class="form-item remark-item">
          <el-input type="textarea" v-model="form.remark" placeholder="Enter remarks" :rows="3" class="custom-textarea"></el-input>
        </el-form-item>
      </el-form>
    </div>

    <div slot="footer" class="dialog-footer">
      <el-button
        type="primary"
        @click="submitForm"
        class="submit-btn"
        :loading="saving"
        :disabled="saving">
          Save
        </el-button>
        <el-button @click="cancel" class="cancel-btn">
          Cancel
        </el-button>
      </div>
  </el-dialog>
</template>

<script>
export default {
  name: 'ParamDialog',
  props: {
    title: {
      type: String,
      default: 'Add Parameter'
    },
    visible: {
      type: Boolean,
      default: false
    },
    form: {
      type: Object,
      default: () => ({
        id: null,
        paramCode: '',
        paramValue: '',
        valueType: 'string',
        remark: ''
      })
    }
  },
  data() {
    return {
      dialogVisible: this.visible,
      saving: false,
      valueTypeOptions: [
        { value: 'string', label: 'String (string)' },
        { value: 'number', label: 'Number (number)' },
        { value: 'boolean', label: 'Boolean (boolean)' },
      ],
      rules: {
        paramCode: [
          { required: true, message: 'Please enter parameter code', trigger: 'blur' },
          { max: 50, message: 'Length should not exceed 50 characters', trigger: 'blur' }
        ],
        paramValue: [
          { required: true, message: 'Please enter parameter value', trigger: 'blur' },
          { max: 500, message: 'Length should not exceed 500 characters', trigger: 'blur' }
        ],
        valueType: [
          { required: true, message: 'Please select value type', trigger: 'change' }
        ]
      }
    };
  },
  watch: {
    visible(val) {
      this.dialogVisible = val;
    }
  },
  methods: {
    submitForm() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          this.saving = true;
          this.$emit('submit', {
            form: { ...this.form },
            done: (errorMsg) => {
              this.saving = false;
              if (errorMsg) {
                this.$message.error({
                  message: errorMsg,
                  showClose: true
                });
              }
            }
          });
        } else {
          return false;
        }
      });
    },
    cancel() {
      this.$emit('cancel');
      this.handleClose();
    },
    handleClose() {
      this.$refs.form.resetFields();
      this.$emit('update:visible', false);
    }
  }
};
</script>

<style lang="scss" scoped>
.param-dialog {
  ::v-deep .el-dialog {
    border-radius: 10px;
    overflow: hidden;
  }

  ::v-deep .el-dialog__header {
    background: #f5f7fa;
    padding: 15px 20px;
    border-bottom: 1px solid #e4e7ed;
  }

  ::v-deep .el-dialog__title {
    font-size: 16px;
    font-weight: 600;
    color: #303133;
  }

  ::v-deep .el-dialog__body {
    padding: 20px;
  }

  ::v-deep .el-dialog__footer {
    padding: 10px 20px 20px;
    text-align: right;
  }
}

.dialog-content {
  max-height: 60vh;
  overflow-y: auto;
}

.param-form {
  .form-item {
    margin-bottom: 18px;
  }

  .remark-item {
    margin-bottom: 0;
  }
}

.custom-input,
.custom-select,
.custom-textarea {
  width: 100%;
}

.submit-btn {
  background: linear-gradient(135deg, #6b8cff, #a966ff);
  border: none;
  padding: 10px 20px;
  font-size: 14px;
  border-radius: 4px;
  transition: all 0.3s;

  &:hover {
    opacity: 0.9;
    transform: translateY(-1px);
  }

  &:active {
    transform: translateY(0);
  }
}

.cancel-btn {
  padding: 10px 20px;
  font-size: 14px;
  border-radius: 4px;
  border: 1px solid #dcdfe6;
  background: white;
  color: #606266;
  transition: all 0.3s;

  &:hover {
    color: #409eff;
    border-color: #c6e2ff;
    background-color: #ecf5ff;
  }
}
</style>