<template>
  <el-dialog :visible="dialogVisible" @update:visible="handleVisibleChange" width="57%" center
    custom-class="custom-dialog" :show-close="false" class="center-dialog">
    <div style="margin: 0 18px; text-align: left; padding: 10px; border-radius: 10px;">
      <div style="font-size: 30px; color: #3d4566; margin-top: -10px; margin-bottom: 10px; text-align: center;">
        Add Model
      </div>

      <button class="custom-close-btn" @click="handleClose">
        ×
      </button>

      <!-- Model Information Section -->
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <div style="font-size: 20px; font-weight: bold; color: #3d4566;">Model Information</div>
        <div style="display: flex; align-items: center; gap: 20px;">
          <div style="display: flex; align-items: center;">
            <span style="margin-right: 8px;">Enabled</span>
            <el-switch v-model="formData.isEnabled" class="custom-switch"></el-switch>
          </div>
          <div style="display: none; align-items: center;">
            <span style="margin-right: 8px;">Set as Default</span>
            <el-switch v-model="formData.isDefault" class="custom-switch"></el-switch>
          </div>
        </div>
      </div>

      <div style="height: 2px; background: #e9e9e9; margin-bottom: 22px;"></div>
      <el-form :model="formData" label-width="100px" label-position="left" class="custom-form">
        <div style="display: flex; gap: 20px; margin-bottom: 0;">
          <el-form-item label="Model Name" prop="modelName" style="flex: 1;">
            <el-input v-model="formData.modelName" placeholder="Enter model name" class="custom-input-bg"></el-input>
          </el-form-item>
          <el-form-item label="Model Code" prop="modelCode" style="flex: 1;">
            <el-input v-model="formData.modelCode" placeholder="Enter model code" class="custom-input-bg"></el-input>
          </el-form-item>
        </div>

        <div style="display: flex; gap: 20px; margin-bottom: 0;">
          <el-form-item label="Provider" prop="supplier" style="flex: 1;">
            <el-select v-model="formData.supplier" placeholder="Please select" class="custom-select custom-input-bg"
              style="width: 100%;" @focus="loadProviders" filterable>
              <el-option v-for="item in providers" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="Sort Order" prop="sortOrder" style="flex: 1;">
            <el-input v-model="formData.sort" type="number" placeholder="Enter sort order" class="custom-input-bg"></el-input>
          </el-form-item>
        </div>


        <el-form-item label="Documentation" prop="docLink" style="margin-bottom: 27px;">
          <el-input v-model="formData.docLink" placeholder="Enter documentation URL" class="custom-input-bg"></el-input>
        </el-form-item>

        <el-form-item label="Remarks" prop="remark" class="prop-remark">
          <el-input v-model="formData.remark" type="textarea" :rows="3" placeholder="Enter model remarks" :autosize="{ minRows: 3, maxRows: 5 }"
            class="custom-input-bg"></el-input>
        </el-form-item>
      </el-form>

      <div style="font-size: 20px; font-weight: bold; color: #3d4566; margin-bottom: 15px;">API Information</div>
      <div style="height: 2px; background: #e9e9e9; margin-bottom: 22px;"></div>

      <el-form :model="formData.configJson" label-width="auto" label-position="left" class="custom-form">
        <template v-for="(row, rowIndex) in chunkedCallInfoFields">
          <div :key="rowIndex" style="display: flex; gap: 20px; margin-bottom: 0;">
            <el-form-item v-for="field in row" :key="field.prop" :label="field.label" :prop="field.prop"
              style="flex: 1;">
              <template v-if="field.type === 'select' && field.prop === 'model_name' && formData.supplier === 'whisper'">
                <el-select v-model="formData.configJson[field.prop]" placeholder="Select model size" class="custom-input-bg">
                  <el-option label="Tiny (39M)" value="tiny" />
                  <el-option label="Base (74M)" value="base" />
                  <el-option label="Small (244M)" value="small" />
                  <el-option label="Medium (769M)" value="medium" />
                  <el-option label="Large (1550M)" value="large" />
                </el-select>
              </template>
              <template v-else-if="field.type === 'select' && field.prop === 'language' && formData.supplier === 'whisper'">
                <el-select v-model="formData.configJson[field.prop]" placeholder="Select language or auto-detect" class="custom-input-bg" 
                  allow-create filterable default-first-option>
                  <el-option label="Auto-detect" value="null" />
                  <el-option label="English (en)" value="en" />
                  <el-option label="Spanish (es)" value="es" />
                  <el-option label="French (fr)" value="fr" />
                  <el-option label="German (de)" value="de" />
                  <el-option label="Japanese (ja)" value="ja" />
                  <el-option label="Chinese (zh)" value="zh" />
                  <el-option label="Korean (ko)" value="ko" />
                  <el-option label="Russian (ru)" value="ru" />
                  <el-option label="Italian (it)" value="it" />
                  <el-option label="Portuguese (pt)" value="pt" />
                  <el-option label="Arabic (ar)" value="ar" />
                  <el-option label="Hindi (hi)" value="hi" />
                  <el-option label="Turkish (tr)" value="tr" />
                  <el-option label="Dutch (nl)" value="nl" />
                  <el-option label="Polish (pl)" value="pl" />
                </el-select>
              </template>
              <el-input v-else v-model="formData.configJson[field.prop]" :placeholder="field.placeholder"
                :type="field.type || 'text'" class="custom-input-bg" :show-password="field.type === 'password'">
              </el-input>
            </el-form-item>
          </div>
        </template>
      </el-form>
    </div>

    <div style="display: flex;justify-content: center;">
      <el-button
        type="primary"
        @click="confirm"
        class="save-btn"
        :loading="saving"
        :disabled="saving">
        Save
      </el-button>
    </div>
  </el-dialog>
</template>

<script>
import Api from '@/apis/api';
export default {
  name: 'AddModelDialog',
  props: {
    visible: { type: Boolean, required: true },
    modelType: { type: String, required: true }
  },
  data() {
    return {
      saving: false,
      providers: [],
      dialogVisible: false,
      providersLoaded: false,
      providerFields: [],
      currentProvider: null,
      formData: {
        modelName: '',
        modelCode: '',
        supplier: '',
        sort: 1,
        docLink: '',
        remark: '',
        isEnabled: true,
        isDefault: true,
        configJson: {}
      }
    }
  },
  watch: {
    visible(val) {
      this.dialogVisible = val;
      if (val) {
        this.initConfigJson();
      } else {
        this.resetForm();
      }
    },
    'formData.supplier'(newVal) {
      this.currentProvider = this.providers.find(p => p.value === newVal);
      
      // Special handling for Whisper ASR
      if (newVal === 'whisper' && this.modelType === 'asr') {
        // Add Whisper-specific fields
        const whisperFields = [
          { label: 'Model Size', prop: 'model_name', type: 'select', placeholder: 'Select model size' },
          { label: 'Language', prop: 'language', type: 'select', placeholder: 'Select language or auto-detect' },
          { label: 'Output Directory', prop: 'output_dir', type: 'text', placeholder: 'Enter output directory' }
        ];
        
        // Set default values for Whisper
        this.formData.configJson.model_name = 'base';
        this.formData.configJson.language = 'null';
        this.formData.configJson.output_dir = 'tmp/';
        
        // Add Whisper fields to provider fields
        this.providerFields = whisperFields;
      } else {
        this.providerFields = this.currentProvider?.fields || [];
        this.initDynamicConfig();
      }
    }
  },
  computed: {
    dynamicCallInfoFields() {
      return this.providerFields;
    },
    chunkedCallInfoFields() {
      const chunkSize = 2;
      const result = [];
      for (let i = 0; i < this.dynamicCallInfoFields.length; i += chunkSize) {
        result.push(this.dynamicCallInfoFields.slice(i, i + chunkSize));
      }
      return result;
    }
  },
  methods: {
    loadProviders() {
      if (this.providersLoaded)
        return

      Api.model.getModelProviders(this.modelType, (data) => {
        this.providers = data.map(item => {
          let fields = JSON.parse(item.fields || '[]');
          
          // Special handling for Whisper ASR
          if (item.providerCode === 'whisper' && this.modelType === 'asr') {
            fields = [
              { key: 'model_name', label: 'Model Size', type: 'select' },
              { key: 'language', label: 'Language', type: 'select' },
              { key: 'output_dir', label: 'Output Directory', type: 'text' }
            ];
          }
          
          return {
            label: item.name,
            value: item.providerCode,
            fields: fields.map(f => ({
              label: f.label,
              prop: f.key,
              type: f.type === 'password' ? 'password' : 
                    f.type === 'select' ? 'select' : 'text',
              placeholder: `Enter ${f.label}`
            }))
          };
        });
        this.providersLoaded = true;
      });
    },
    initConfigJson() {
      const defaultConfig = {};
      this.providerFields.forEach(field => {
        defaultConfig[field.prop] = '';
      });
      this.formData.configJson = { ...defaultConfig };
    },
    handleVisibleChange(val) {
      this.dialogVisible = val;
      this.$emit('update:visible', val);
      if (!val) {
        this.resetForm();
      }
    },

    handleClose() {
      this.saving = false;
      this.$emit('update:visible', false);
    },
    initDynamicConfig() {
      const newConfig = {};
      this.providerFields.forEach(field => {
        newConfig[field.prop] = this.formData.configJson[field.prop] || '';
      });
      this.formData.configJson = newConfig;
    },
    confirm() {
      this.saving = true;

      if (!this.formData.supplier) {
        this.$message.error('Please select a provider');
        this.saving = false;
        return;
      }

      // Special handling for Whisper language field
      if (this.formData.supplier === 'whisper' && this.formData.configJson.language === 'null') {
        this.formData.configJson.language = null;
      }

      const submitData = {
        modelName: this.formData.modelName || '',
        modelCode: this.formData.modelCode || '',
        supplier: this.formData.supplier,
        sort: this.formData.sort || 1,
        docLink: this.formData.docLink || '',
        remark: this.formData.remark || '',
        isEnabled: this.formData.isEnabled ? 1 : 0,
        isDefault: this.formData.isDefault ? 1 : 0,
        provideCode: this.formData.supplier,
        configJson: {
          ...this.formData.configJson,
          type: this.formData.supplier
        }
      };

      try {
        this.$emit('confirm', submitData);
        this.$emit('update:visible', false);
        this.resetForm();
      } catch (e) {
        console.error(e);
      } finally {
        this.saving = false;
      }
    },
    resetForm() {
      this.saving = false;
      this.formData = {
        modelName: '',
        modelCode: '',
        supplier: '',
        sort: 1,
        docLink: '',
        remark: '',
        isEnabled: true,
        isDefault: true,
        configJson: {}
      };
      // Reset loading state
      this.providers = [];
      this.providersLoaded = false;
      // Reset field configuration
      this.providerFields = [];
      this.currentProvider = null;
    },
  }
}
</script>

<style>
.custom-dialog {
  position: relative;
  border-radius: 20px;
  overflow: hidden;
  background: white;
  padding-bottom: 17px;
}

.custom-dialog .el-dialog__header {
  padding: 0;
  border-bottom: none;
}

.center-dialog {
  display: flex;
  align-items: center;
  justify-content: center;
}

.center-dialog .el-dialog {
  margin: 0 0 auto !important;
  display: flex;
  flex-direction: column;
}

.custom-close-btn {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 35px;
  height: 35px;
  border-radius: 50%;
  border: 2px solid #cfcfcf;
  background: none;
  font-size: 30px;
  font-weight: lighter;
  color: #cfcfcf;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1;
  padding: 0;
  outline: none;
}

.custom-close-btn:hover {
  color: #409EFF;
  border-color: #409EFF;
}

.custom-select .el-input__suffix {
  background: #e6e8ea;
  right: 6px;
  width: 20px;
  height: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  top: 9px;
}

.custom-select .el-input__suffix-inner {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
}

.custom-select .el-icon-arrow-up:before {
  content: "";
  display: inline-block;
  width: 0;
  height: 0;
  border-left: 5px solid transparent;
  border-right: 5px solid transparent;
  border-top: 7px solid #c0c4cc;
  position: relative;
  top: -2px;
  transform: rotate(180deg);
}

.custom-form .el-form-item {
  margin-bottom: 20px;
}

.custom-form .el-form-item__label {
  color: #3d4566;
  font-weight: normal;
  text-align: right;
  padding-right: 20px;

}

.custom-form .el-form-item.prop-remark .el-form-item__label {
  margin-top: -4px;
}

.custom-input-bg .el-input__inner::-webkit-input-placeholder,
.custom-input-bg .el-textarea__inner::-webkit-input-placeholder {
  color: #9c9f9e;
}


.custom-input-bg .el-input__inner,
.custom-input-bg .el-textarea__inner {
  background-color: #f6f8fc;
}


.save-btn {
  background: #e6f0fd;
  color: #237ff4;
  border: 1px solid #b3d1ff;
  width: 150px;
  height: 40px;
  font-size: 16px;
  transition: all 0.3s ease;
}

.save-btn:hover {
  background: linear-gradient(to right, #237ff4, #9c40d5);
  color: white;
  border: none;
}


.custom-switch .el-switch__core {
  border-radius: 20px;
  height: 23px;
  background-color: #c0ccda;
  width: 35px;
  padding: 0 20px;
}

.custom-switch .el-switch__core:after {
  width: 15px;
  height: 15px;
  background-color: white;
  top: 3px;
  left: 4px;
  transition: all .3s;
}

.custom-switch.is-checked .el-switch__core {
  border-color: #b5bcf0;
  background-color: #cfd7fa;
  padding: 0 20px;
}

.custom-switch.is-checked .el-switch__core:after {
  left: 100%;
  margin-left: -18px;
  background-color: #1b47ee;
}


[style*="display: flex"] {
  gap: 20px;
}

.custom-input-bg .el-input__inner {
  height: 32px;
}
</style>