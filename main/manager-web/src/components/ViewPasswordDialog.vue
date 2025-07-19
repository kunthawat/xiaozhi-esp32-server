<template>
  <el-dialog :visible.sync="visible" width="400px" :show-close="false" :close-on-click-modal="false"
    :close-on-press-escape="false" class="custom-dialog">
    <div class="dialog-header">
      <div style="font-weight: 700;font-size: 16px;text-align: left;color: white;">
        <img src="@/assets/home/password.png" alt=""
          style="width: 19px;height: 23px; filter: brightness(0) invert(1);" />
      </div>
      User New Password
    </div>
    <div style="height: 1px;background: #e8f0ff;" />
    <div class="dialog-content">
      <div style="font-weight: 400;font-size: 14px;text-align: left;color: #3d4566;">
        <div style="color: red;display: inline-block;">*</div>
        User New Password:
      </div>
      <div class="input-46" style="margin-top: 12px;">
        <div class="password-display">{{ password }}</div>
      </div>
    </div>
    <div class="dialog-footer">
      <div class="dialog-btn" style="background: #e6ebff;border: 1px solid #adbdff;color: #5778ff;"
        @click="closeDialog">
        Close
      </div>
      <div class="dialog-btn" style="background: #5778ff;color: white;" @click="copyPassword">
        Copy Password
      </div>
    </div>
  </el-dialog>
</template>

<script>
export default {
  name: 'ViewPasswordDialog',
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    password: {
      type: String,
      default: ''
    }
  },
  methods: {
    closeDialog() {
      this.$emit('update:visible', false)
    },
    copyPassword() {
      navigator.clipboard.writeText(this.password)
      this.$message.success({
        message: 'Password copied',
        showClose: true
      })
    }
  }
}
</script>

<style scoped>
.custom-dialog {
  border-radius: 10px;
  overflow: hidden;
}

.dialog-header {
  background: #5778ff;
  height: 50px;
  display: flex;
  align-items: center;
  padding: 0 20px;
  color: white;
  font-size: 16px;
  font-weight: 700;
  gap: 10px;
}

.dialog-content {
  padding: 20px;
}

.password-display {
  width: 100%;
  height: 40px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  display: flex;
  align-items: center;
  padding: 0 15px;
  font-size: 14px;
  color: #606266;
  background-color: #f5f7fa;
}

.dialog-footer {
  padding: 10px 20px 20px;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

.dialog-btn {
  padding: 9px 15px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.3s;
}

.dialog-btn:hover {
  opacity: 0.9;
}

:deep(.el-dialog) {
  border-radius: 10px;
  overflow: hidden;
  margin-top: 15vh !important;
}

:deep(.el-dialog__header) {
  padding: 0;
}

:deep(.el-dialog__body) {
  padding: 0;
}

:deep(.el-dialog__headerbtn) {
  display: none;
}
</style>