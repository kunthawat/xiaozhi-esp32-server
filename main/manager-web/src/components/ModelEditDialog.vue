<template>
  <el-dialog :visible.sync="dialogVisible" :close-on-click-modal="false" width="57%" center custom-class="custom-dialog" :show-close="false"
    class="center-dialog" >
    <div style="margin: 0 18px; text-align: left; padding: 10px; border-radius: 10px;">
      <div style="font-size: 30px; color: #3d4566; margin-top: -10px; margin-bottom: 10px; text-align: center;">
        Edit Model
      </div>

      <button class="custom-close-btn" @click="dialogVisible = false">
        ×
      </button>

      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <div style="font-size: 20px; font-weight: bold; color: #3d4566;">Model Information</div>
        <div style="display: flex; align-items: center; gap: 20px;">
          <div style="display: flex; align-items: center;">
            <span style="margin-right: 8px;">Enabled</span>
            <el-switch v-model="form.isEnabled" :active-value="1" :inactive-value="0" class="custom-switch"></el-switch>
          </div>
          <div style="display: none; align-items: center;">
            <span style="margin-right: 8px;">Set as Default</span>
            <el-switch v-model="form.isDefault" :active-value="1" :inactive-value="0" class="custom-switch"></el-switch>
          </div>
        </div>
      </div>

      <div style="height: 2px; background: #e9e9e9; margin-bottom: 22px;"></div>

      <el-form :model="form" ref="form" label-width="100px" label-position="left" class="custom-form">
        <div style="display: flex; gap: 20px; margin-bottom: 0;">
          <el-form-item label="Model Name" prop="name" style="flex: 1;">
            <el-input v-model="form.modelName" placeholder="Enter model name" class="custom-input-bg"></el-input>
          </el-form-item>
          <el-form-item label="Model Code" prop="code" style="flex: 1;">
            <el-input v-model="form.modelCode" placeholder="Enter model code" class="custom-input-bg"></el-input>
          </el-form-item>
        </div>

        <div style="display: flex; gap: 20px; margin-bottom: 0;">
          <el-form-item label="Provider" prop="supplier" style="flex: 1;">
            <el-select v-model="form.configJson.type" placeholder="Please select" class="custom-select custom-input-bg"
              style="width: 100%;" @focus="loadProviders" filterable>
              <el-option v-for="item in providers" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="Sort Order" prop="sort" style="flex: 1;">
            <el-input v-model.number="form.sort" type="number" placeholder="Enter sort order" class="custom-input-bg"></el-input>
          </el-form-item>
        </div>

        <el-form-item label="Documentation" prop="docUrl" style="margin-bottom: 27px;">
          <el-input v-model="form.docLink" placeholder="Enter documentation URL" class="custom-input-bg"></el-input>
        </el-form-item>

        <el-form-item label="Remarks" prop="remark" class="prop-remark">
          <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="Enter model remarks" :autosize="{ minRows: 3, maxRows: 5 }"
            class="custom-input-bg"></el-input>
        </el-form-item>
      </el-form>

      <div style="font-size: 20px; font-weight: bold; color: #3d4566; margin-bottom: 15px;">API Information</div>
      <div style="height: 2px; background: #e9e9e9; margin-bottom: 22px;"></div>

      <el-form :model="form.configJson" ref="callInfoForm" label-width="auto" class="custom-form">
        <template v-for="(row, rowIndex) in chunkedCallInfoFields">
          <div :key="rowIndex" style="display: flex; gap: 20px; margin-bottom: 0;">
            <el-form-item v-for="field in row" :key="field.prop" :label="field.label" :prop="field.prop"
              style="flex: 1;">
              <template v-if="field.type === 'json-textarea'">
                <el-input v-model="fieldJsonMap[field.prop]" type="textarea" :rows="3" placeholder="Enter JSON format variables (example:{'key':'value'})"
                  class="custom-input-bg" @change="(val) => handleJsonChange(field.prop, val)"></el-input>
              </template>
              <template v-else-if="field.type === 'select' && field.prop === 'model_name' && form.configJson.type === 'whisper'">
                <el-select v-model="form.configJson[field.prop]" placeholder="Select model size" class="custom-input-bg">
                  <el-option label="Tiny (39M)" value="tiny" />
                  <el-option label="Base (74M)" value="base" />
                  <el-option label="Small (244M)" value="small" />
                  <el-option label="Medium (769M)" value="medium" />
                  <el-option label="Large (1550M)" value="large" />
                </el-select>
              </template>
              <template v-else-if="field.type === 'select' && field.prop === 'language' && form.configJson.type === 'whisper'">
                <el-select v-model="form.configJson[field.prop]" placeholder="Select language or auto-detect" class="custom-input-bg" 
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
              <el-input v-else v-model="form.configJson[field.prop]" :placeholder="field.placeholder" :type="field.type"
                class="custom-input-bg" :show-password="field.type === 'password'"></el-input>
            </el-form-item>
          </div>
        </template>
      </el-form>
    </div>

    <div style="display: flex;justify-content: center;">
      <el-button
        type="primary"
        @click="handleSave"
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
  name: "ModelEditDialog",
  props: {
    visible: { type: Boolean, default: false },
    modelData: {
      type: Object,
      default: () => ({}),
      validator: value => typeof value === 'object' && !Array.isArray(value)
    },
    modelType: { type: String, required: true }
  },
  data() {
    return {
      dialogVisible: this.visible,
      providers: [],
      providersLoaded: false,
      saving: false,
      allProvidersData: null,
      pendingProviderType: null,
      pendingModelData: null,
      dynamicCallInfoFields: [],
      fieldJsonMap: {}, // For storing JSON fields as strings
      form: {
        id: "",
        modelType: "",
        modelCode: "",
        modelName: "",
        isDefault: false,
        isEnabled: false,
        docLink: "",
        remark: "",
        sort: 0,
        configJson: {}
      }
    };
  },
  computed: {
    chunkedCallInfoFields() {
      const chunkSize = 2;
      const result = [];
      for (let i = 0; i < this.dynamicCallInfoFields.length; i += chunkSize) {
        result.push(this.dynamicCallInfoFields.slice(i, i + chunkSize));
      }
      return result;
    },
  },
  watch: {
    modelType() {
      this.resetProviders();
      this.loadProviders();
    },
    dialogVisible(val) {
      this.$emit('update:visible', val);
      if (!val) {
        this.resetForm();
      } else if (val && this.modelData.id) {
        this.loadModelData();
      }
    },
    visible(val) {
      this.dialogVisible = val;
      if (val) {
        this.loadProviders();
      }
    },
    'form.configJson.type'(newVal) {
      if (newVal && this.providersLoaded) {
        this.loadProviderFields(newVal);
        
        // Special handling for Whisper ASR
        if (newVal === 'whisper' && this.modelType === 'asr') {
          // Set default values for Whisper if they don't exist
          if (!this.form.configJson.model_name) {
            this.form.configJson.model_name = 'base';
          }
          if (!this.form.configJson.language) {
            this.form.configJson.language = 'null';
          }
          if (!this.form.configJson.output_dir) {
            this.form.configJson.output_dir = 'tmp/';
          }
        }
      }
    }
  },
  methods: {
    resetForm() {
      this.form = {
        id: "",
        modelType: "",
        modelCode: "",
        modelName: "",
        isDefault: false,
        isEnabled: false,
        docLink: "",
        remark: "",
        sort: 0,
        configJson: {}
      };
      this.fieldJsonMap = {};
    },
    resetProviders() {
      this.providers = [];
      this.providersLoaded = false;
    },
    loadModelData() {
      if (this.modelData.id) {
        Api.model.getModelConfig(this.modelData.id, ({ data }) => {
          if (data.code === 0 && data.data) {
            const model = data.data;
            this.pendingProviderType = model.configJson.type;
            this.pendingModelData = model;

            if (this.providersLoaded) {
              this.loadProviderFields(model.configJson.type);
            } else {
              this.loadProviders();
            }
          }
        });
      }
    },
    handleSave() {
      this.saving = true; // Start saving loading

      // Process all JSON fields
      Object.keys(this.fieldJsonMap).forEach(key => {
        const parsed = this.validateJson(this.fieldJsonMap[key]);
        if (parsed !== null) {
          this.form.configJson[key] = parsed;
        }
      });

      // Special handling for Whisper language field
      if (this.form.configJson.type === 'whisper' && this.form.configJson.language === 'null') {
        this.form.configJson.language = null;
      }

      const formData = {
        id: this.modelData.id,
        modelCode: this.form.modelCode,
        modelName: this.form.modelName,
        isDefault: this.form.isDefault ? 1 : 0,
        isEnabled: this.form.isEnabled ? 1 : 0,
        docLink: this.form.docLink,
        remark: this.form.remark,
        sort: this.form.sort || 0,
        configJson: { ...this.form.configJson }
      };

      this.$emit("save", {
        provideCode: this.form.configJson.type,
        formData,
        done: () => {
          this.saving = false; // Callback after saving is complete
        }
      });

      // If parent component doesn't handle done callback, automatically close loading state after 3 seconds
      setTimeout(() => {
        this.saving = false;
      }, 3000);
    },
    loadProviders() {
      if (this.providersLoaded) return;

      Api.model.getModelProviders(this.modelType, (data) => {
        this.providers = data.map(item => ({
          label: item.name,
          value: String(item.providerCode)
        }));
        this.providersLoaded = true;
        this.allProvidersData = data;

        if (this.pendingProviderType) {
          this.loadProviderFields(this.pendingProviderType);
        }
      });
    },
    loadProviderFields(providerCode) {
      if (this.allProvidersData) {
        const provider = this.allProvidersData.find(p => p.providerCode === providerCode);
        if (provider) {
          let fields = JSON.parse(provider.fields || '[]');
          
          // Special handling for Whisper ASR
          if (providerCode === 'whisper' && this.modelType === 'asr') {
            // Add or modify fields for Whisper
            const whisperFields = [
              { key: 'model_name', label: 'Model Size', type: 'select' },
              { key: 'language', label: 'Language', type: 'select' },
              { key: 'output_dir', label: 'Output Directory', type: 'text' }
            ];
            
            // Replace or add Whisper-specific fields
            whisperFields.forEach(wField => {
              const existingIndex = fields.findIndex(f => f.key === wField.key);
              if (existingIndex >= 0) {
                fields[existingIndex] = wField;
              } else {
                fields.push(wField);
              }
            });
          }
          
          this.dynamicCallInfoFields = fields.map(f => ({
            label: f.label,
            prop: f.key,
            type: f.type === 'dict' ? 'json-textarea' : (
                  f.type === 'password' ? 'password' : 
                  f.type === 'select' ? 'select' : 'text'),
            placeholder: `Enter ${f.label}`
          }));

          if (this.pendingModelData && this.pendingProviderType === providerCode) {
            this.processModelData(this.pendingModelData);
            this.pendingModelData = null;
            this.pendingProviderType = null;
          }
        }
      }
    },
    processModelData(model) {
      let configJson = model.configJson || {};
      this.dynamicCallInfoFields.forEach(field => {
        if (!configJson.hasOwnProperty(field.prop)) {
          configJson[field.prop] = '';
        } else if (field.type === 'json-textarea') {
          this.$set(this.fieldJsonMap, field.prop, this.formatJson(configJson[field.prop]));
          configJson[field.prop] = this.ensureObject(configJson[field.prop]);
        } else if (typeof configJson[field.prop] !== 'string' && configJson[field.prop] !== null) {
          configJson[field.prop] = String(configJson[field.prop]);
        } else if (configJson[field.prop] === null && field.prop === 'language') {
          // Special handling for Whisper language field
          configJson[field.prop] = 'null';
        }
      });

      this.form = {
        id: model.id,
        modelType: model.modelType,
        modelCode: model.modelCode,
        modelName: model.modelName,
        isDefault: model.isDefault,
        isEnabled: model.isEnabled,
        docLink: model.docLink,
        remark: model.remark,
        sort: Number(model.sort) || 0,
        configJson: { ...configJson }
      };
    },
    handleJsonChange(field, value) {
      const parsed = this.validateJson(value);
      if (parsed !== null) {
        this.form.configJson[field] = parsed;
      }
    },
    validateJson(value) {
      try {
        const parsed = JSON.parse(value);
        if (typeof parsed === 'object' && parsed !== null && !Array.isArray(parsed)) {
          return parsed;
        }
        this.$message.error({
          message: 'Must enter dictionary format (e.g. {"key":"value"}), original data will be used if invalid',
          showClose: true
        });
        return null;
      } catch (e) {
        this.$message.error({
          message: 'JSON format error (e.g. {"key":"value"}), original data will be used if invalid',
          showClose: true
        });
        return null;
      }
    },
    formatJson(obj) {
      try {
        return JSON.stringify(obj, null, 2);
      } catch {
        return '';
      }
    },
    ensureObject(value) {
      return typeof value === 'object' ? value : {};
    }
  }
};
</script>

<style lang="scss" scoped>
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

.custom-form .el-form-item {
  margin-bottom: 20px;
}

.custom-form .el-form-item__label {
  color: #3d4566;
  font-weight: normal;
  text-align: right;
  padding-right: 20px;
}
</style>