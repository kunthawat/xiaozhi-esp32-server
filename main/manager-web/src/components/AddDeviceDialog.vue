<template>
  <el-dialog :visible="visible" @close="handleClose" width="24%" center>
    <div
      style="margin: 0 10px 10px;display: flex;align-items: center;gap: 10px;font-weight: 700;font-size: 20px;text-align: left;color: #3d4566;">
      <div
        style="width: 40px;height: 40px;border-radius: 50%;background: #5778ff;display: flex;align-items: center;justify-content: center;">
        <img src="@/assets/home/equipment.png" alt="" style="width: 18px;height: 15px;" />
      </div>
      Add Device
    </div>
    <div style="height: 1px;background: #e8f0ff;" />
    <div style="margin: 22px 15px;">
      <div style="font-weight: 400;font-size: 14px;text-align: left;color: #3d4566;">
        <div style="color: red;display: inline-block;">*</div>
        <span style="font-size: 11px"> Verification Code:</span>
      </div>
      <div class="input-46" style="margin-top: 12px;">
        <el-input placeholder="Enter the 6-digit verification code from the device.." v-model="deviceCode" @keyup.enter.native="confirm" />
      </div>
    </div>
    <div style="display: flex;margin: 15px 15px;gap: 7px;">
      <div class="dialog-btn" @click="confirm">
        Confirm
      </div>
      <div class="dialog-btn" style="background: #e6ebff;border: 1px solid #adbdff;color: #5778ff;" @click="cancel">
        Cancel
      </div>
    </div>
  </el-dialog>
</template>

<script>
import Api from '@/apis/api';

export default {
  name: 'AddDeviceDialog',
  props: {
    visible: { type: Boolean, required: true },
    agentId: { type: String, required: true }
  },
  data() {
    return {
      deviceCode: "",
      loading: false,
    }
  },
  methods: {
    confirm() {
      if (!/^\d{6}$/.test(this.deviceCode)) {
        this.$message.error('Please enter a 6-digit verification code');
        return;
      }
      this.loading = true;
      Api.device.bindDevice(
        this.agentId,
        this.deviceCode, ({ data }) => {
          this.loading = false;
          if (data.code === 0) {
            this.$emit('refresh');
            this.$message.success({
              message: 'Device bound successfully',
              showClose: true
            });
            this.closeDialog();
          } else {
            this.$message.error({
              message: data.msg || 'Binding failed',
              showClose: true
            });
          }
        }
      );
    },
    closeDialog() {
      this.$emit('update:visible', false);
      this.deviceCode = '';

    },
    cancel() {
      this.$emit('update:visible', false)
      this.deviceCode = ""
    },
    handleClose() {
      this.$emit('update:visible', false);
    },
  }
}
</script>

<style scoped>
.input-46 {
  border: 1px solid #e4e6ef;
  background: #f6f8fb;
  border-radius: 10px;
}

.dialog-btn {
  cursor: pointer;
  flex: 1;
  border-radius: 23px;
  background: #5778ff;
  height: 40px;
  font-weight: 500;
  font-size: 12px;
  color: #fff;
  line-height: 40px;
  text-align: center;
}

::v-deep .el-dialog {
  border-radius: 15px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

::v-deep .el-dialog__headerbtn {
  display: none;
}

::v-deep .el-dialog__body {
  padding: 4px 6px;
}

::v-deep .el-dialog__header {
  padding: 10px;
}
</style>