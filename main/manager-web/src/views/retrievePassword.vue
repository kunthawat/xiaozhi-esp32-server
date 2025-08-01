<template>
  <div class="welcome" @keyup.enter="retrievePassword">
    <el-container style="height: 100%;">
      <!-- Keep the same header -->
      <el-header>
        <div style="display: flex;align-items: center;margin-top: 15px;margin-left: 10px;gap: 10px;">
          <img loading="lazy" alt="" src="@/assets/xiaozhi-logo.png" style="width: 45px;height: 45px;" />
          <img loading="lazy" alt="" src="@/assets/xiaozhi-ai.png" style="height: 18px;" />
        </div>
      </el-header>
      <div class="login-person">
        <img loading="lazy" alt="" src="@/assets/login/register-person.png" style="width: 100%;" />
      </div>
      <el-main style="position: relative;">
        <form @submit.prevent="retrievePassword">
          <div class="login-box">
            <!-- Modified title section -->
            <div style="display: flex;align-items: center;gap: 20px;margin-bottom: 39px;padding: 0 30px;">
              <img loading="lazy" alt="" src="@/assets/login/hi.png" style="width: 34px;height: 34px;" />
              <div class="login-text">Reset Password</div>
              <div class="login-welcome">
                PASSWORD RETRIEVE
              </div>
            </div>

            <div style="padding: 0 30px;">
              <!-- Mobile number input -->
              <div class="input-box">
                <div style="display: flex; align-items: center; width: 100%;">
                  <el-select v-model="form.areaCode" style="width: 220px; margin-right: 10px;">
                    <el-option v-for="item in mobileAreaList" :key="item.key" :label="`${item.name} (${item.key})`"
                      :value="item.key" />
                  </el-select>
                  <el-input v-model="form.mobile" placeholder="Please enter mobile number" />
                </div>
              </div>

              <div style="display: flex; align-items: center; margin-top: 20px; width: 100%; gap: 10px;">
                <div class="input-box" style="width: calc(100% - 130px); margin-top: 0;">
                  <img loading="lazy" alt="" class="input-icon" src="@/assets/login/shield.png" />
                  <el-input v-model="form.captcha" placeholder="Please enter verification code" style="flex: 1;" />
                </div>
                <img loading="lazy" v-if="captchaUrl" :src="captchaUrl" alt="Verification Code"
                  style="width: 150px; height: 40px; cursor: pointer;" @click="fetchCaptcha" />
              </div>

              <!-- Mobile verification code -->
              <div style="display: flex; align-items: center; margin-top: 20px; width: 100%; gap: 10px;">
                <div class="input-box" style="width: calc(100% - 130px); margin-top: 0;">
                  <img loading="lazy" alt="" class="input-icon" src="@/assets/login/phone.png" />
                  <el-input v-model="form.mobileCaptcha" placeholder="Please enter mobile verification code" style="flex: 1;" maxlength="6" />
                </div>
                <el-button type="primary" class="send-captcha-btn" :disabled="!canSendMobileCaptcha"
                  @click="sendMobileCaptcha">
                  <span>
                    {{ countdown > 0 ? `Retry in ${countdown}s` : 'Send Code' }}
                  </span>
                </el-button>
              </div>

              <!-- New password -->
              <div class="input-box">
                <img loading="lazy" alt="" class="input-icon" src="@/assets/login/password.png" />
                <el-input v-model="form.newPassword" placeholder="Please enter new password" type="password" show-password />
              </div>

              <!-- Confirm new password -->
              <div class="input-box">
                <img loading="lazy" alt="" class="input-icon" src="@/assets/login/password.png" />
                <el-input v-model="form.confirmPassword" placeholder="Please confirm new password" type="password" show-password />
              </div>

              <!-- Modified bottom link -->
              <div style="font-weight: 400;font-size: 14px;text-align: left;color: #5778ff;margin-top: 20px;">
                <div style="cursor: pointer;" @click="goToLogin">Back to Login</div>
              </div>
            </div>

            <!-- Modified button text -->
            <div class="login-btn" @click="retrievePassword">Reset Now</div>

            <!-- Keep the same agreement statement -->
            <div style="font-size: 14px;color: #979db1;">
              Agree to the
              <div style="display: inline-block;color: #5778FF;cursor: pointer;">User Agreement</div>
              and
              <div style="display: inline-block;color: #5778FF;cursor: pointer;">Privacy Policy</div>
            </div>
          </div>
        </form>
      </el-main>

      <!-- Keep the same footer -->
      <el-footer>
        <version-footer />
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import Api from '@/apis/api';
import VersionFooter from '@/components/VersionFooter.vue';
import { getUUID, goToPage, showDanger, showSuccess, validateMobile } from '@/utils';
import { mapState } from 'vuex';

export default {
  name: 'retrieve',
  components: {
    VersionFooter
  },
  computed: {
    ...mapState({
      allowUserRegister: state => state.pubConfig.allowUserRegister,
      mobileAreaList: state => state.pubConfig.mobileAreaList
    }),
    canSendMobileCaptcha() {
      return this.countdown === 0 && validateMobile(this.form.mobile, this.form.areaCode);
    }
  },
  data() {
    return {
      form: {
        areaCode: '+86',
        mobile: '',
        captcha: '',
        captchaId: '',
        smsCode: '',
        newPassword: '',
        confirmPassword: ''
      },
      captchaUrl: '',
      countdown: 0,
      timer: null
    }
  },
  mounted() {
    this.fetchCaptcha();
  },
  methods: {
    // Reuse verification code acquisition method
    fetchCaptcha() {
      this.form.captchaId = getUUID();
      Api.user.getCaptcha(this.form.captchaId, (res) => {
        if (res.status === 200) {
          const blob = new Blob([res.data], { type: res.data.type });
          this.captchaUrl = URL.createObjectURL(blob);

        } else {
          console.error('Verification code loading error:', error);
          showDanger('Verification code loading failed, click to refresh');
        }
      });
    },

    // Encapsulate input validation logic
    validateInput(input, message) {
      if (!input.trim()) {
        showDanger(message);
        return false;
      }
      return true;
    },

    // Send mobile verification code
    sendMobileCaptcha() {
      if (!validateMobile(this.form.mobile, this.form.areaCode)) {
        showDanger('Please enter a valid mobile number');
        return;
      }

      // Validate graphic verification code
      if (!this.validateInput(this.form.captcha, 'Please enter graphic verification code')) {
        this.fetchCaptcha();
        return;
      }

      // Clear any existing old timer
      if (this.timer) {
        clearInterval(this.timer);
        this.timer = null;
      }

      // Start countdown
      this.countdown = 60;
      this.timer = setInterval(() => {
        if (this.countdown > 0) {
          this.countdown--;
        } else {
          clearInterval(this.timer);
          this.timer = null;
        }
      }, 1000);

      // Call send verification code API
      Api.user.sendSmsVerification({
        phone: this.form.areaCode + this.form.mobile,
        captcha: this.form.captcha,
        captchaId: this.form.captchaId
      }, (res) => {
        showSuccess('Verification code sent successfully');
      }, (err) => {
        showDanger(err.data.msg || 'Verification code sending failed');
        this.countdown = 0;
        this.fetchCaptcha();
      });
    },

    // Reset logic
    retrievePassword() {
      // Validation logic
      if (!validateMobile(this.form.mobile, this.form.areaCode)) {
        showDanger('Please enter a valid mobile number');
        return;
      }
      if (!this.form.captcha) {
        showDanger('Please enter graphic verification code');
        return;
      }
      if (!this.form.mobileCaptcha) {
        showDanger('Please enter SMS verification code');
        return;
      }
      if (this.form.newPassword !== this.form.confirmPassword) {
        showDanger('The two passwords entered are inconsistent');
        return;
      }

      Api.user.retrievePassword({
        phone: this.form.areaCode + this.form.mobile,
        password: this.form.newPassword,
        code: this.form.mobileCaptcha
      }, (res) => {
        showSuccess('Password reset successful');
        goToPage('/login');
      }, (err) => {
        showDanger(err.data.msg || 'Reset failed');
        if (err.data != null && err.data.msg != null && err.data.msg.indexOf('verification code') > -1) {
          this.fetchCaptcha()
        }
      });
    },

    goToLogin() {
      goToPage('/login')
    }
  },
  beforeDestroy() {
    if (this.timer) {
      clearInterval(this.timer);
    }
  }
}
</script>

<style lang="scss" scoped>
@import './auth.scss';

.send-captcha-btn {
  margin-right: -5px;
  min-width: 100px;
  height: 40px;
  line-height: 40px;
  border-radius: 4px;
  font-size: 14px;
  background: rgb(87, 120, 255);
  border: none;
  padding: 0;

  &:disabled {
    background: #c0c4cc;
    cursor: not-allowed;
  }
}
</style>
