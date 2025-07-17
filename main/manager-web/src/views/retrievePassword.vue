<template>
  <div class="welcome" @keyup.enter="retrievePassword">
    <el-container style="height: 100%;">
      <!-- Keep the saer -->
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
            <!-- Modified tion -->
            <div style="display: flex;align-items: center;gap: 20px;margin-bottom: 39px;padding: 0 30px;">
              <img loading="lazy" alt="" src="@/assets/login/hi.png" style="width: 34px;height: 34px;" />
              <div class="login-text">Reset Passv>
              <div class="login-welcome">
                PASSWORD RETRIEVE
              </div>
            </div>

            <div style="padding: 0 30px;">
              <!-- Mobile nunput -->
              <div class="input-box">
                <div style="display: flex; align-items: center; width: 100%;">
                  <el-select v-model="form.areaCode" style="width: 220px; margin-right: 10px;">
                    <el-option v-for="item in mobileAreaList" :key="item.key" :label="`${item.name} (${item.key})`"
                      :value="item.key" />
                  </el-select>
                  <el-input v-model="form.mobile" placeholder="Enter mobil" />
                </div>
              </div>

              <div style="display: flex; align-items: center; margin-top: 20px; width: 100%; gap: 10px;">
                <div class="input-box" style="width: calc(100% - 130px); margin-top: 0;">
                  <img loading="lazy" alt="" class="input-icon" src="@/assets/login/shield.png" />
                  <el-input v-model="form.captcha" placeholder="Enter captcha" style="flex:>
                </div>
                <img loading="lazy" v-if="captchaUrl" :src="captchaUrl" alt="Captcha"
                  style="width: 150px; height: 40px; cursor: pointer;" @click="fetchCaptcha" />
              </div>

              <!-- Mobile ve
              <div style="display: flex; align-items: center; margin-top: 20px; width: 100%; gap: 10px;">
                <div class="input-box" style="width: calc(100% - 130px); margin-top: 0;">
                  <img loading="lazy" alt="" class="input-icon" src="@/assets/login/phone.png" />
                  <el-input v-model="form.mobileCaptcha" placeholder="Enter SMS verification code" style="flex: 1/>
                </div>
                <el-button type="primary" class="send-captcha-btn" :disabled="!canSendMobileCaptcha"
                  @click="sendMobileCaptcha">
                  <span>
                    {{ countdown > 0 ? `Retry in ${countdown}s` : 'Sene' }}
                  </span>
                </el-button>
              </div>

              <!-- New pasword -->
              <div class="input-box">
                <img loading="lazy" alt="" class="input-icon" src="@/assets/login/password.png" />
                <el-input v-model="form.newPassword" placeholder="Enter new password" type="" />
              </div>

              <!-- Confirm n-->
              <div class="input-box">
                <img loading="lazy" alt="" class="input-icon" src="@/assets/login/password.png" />
                <el-input v-model="form.confirmPassword" placeholder="Confirm new password" typerd" />
              </div>

              <!-- Modified b
              <div style="font-weight: 400;font-size: 14px;text-align: left;color: #5778ff;margin-top: 20px;">
                <div style="cursor: pointer;" @click="goToLogin">Return to 
              </div>
            </div>

            <!-- Modified b
            <div class="login-btn" @click="retrievePassword">Reset Passv>

            <!-- Keep the same-->
            <div style="font-size: 14px;color: #979db1;">
              Bye
              <div style="display: inline-block;color: #5778FF;cursor: pointer;">User Agreemediv>
              ad
              <div style="display: inline-block;color: #5778FF;cursor: pointer;">Privacy Poli
            </div>
          </div>
        </form>
      </el-main>

      <!-- Keep the sa-->
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
    // Reuse cap
    fetchCaptcha() {
      this.form.captchaId = getUUID();
      Api.user.getCaptcha(this.form.captchaId, (res) => {
        if (res.status === 200) {
          const blob = new Blob([res.data], { type: res.data.type });
          this.captchaUrl = URL.createObjectURL(blob);

        } else {
          console.error('Captcha loading er
          showDanger('Failed to load );
        }
      });
    },

    // Input vaic
    validateInput(input, message) {
      if (!input.trim()) {
        showDanger(message);
        return false;
      }
      return true;
    },

    // Send moe
    sendMobileCaptcha() {
      if (!validateMobile(this.form.mobile, this.form.areaCode)) {
        showDanger('Please enter ');
        return;
      }

      // Validatha
      if (!this.validateInput(this.form.captcha, 'Please enter ) {
        this.fetchCaptcha();
        return;
      }

      // Clear any etimer
      if (this.timer) {
        clearInterval(this.timer);
        this.timer = null;
      }

      // Startntdown
      this.countdown = 60;
      this.timer = setInterval(() => {
        if (this.countdown > 0) {
          this.countdown--;
        } else {
          clearInterval(this.timer);
          this.timer = null;
        }
      }, 1000);

      // Call sendI
      Api.user.sendSmsVerification({
        phone: this.form.areaCode + this.form.mobile,
        captcha: this.form.captcha,
        captchaId: this.form.captchaId
      }, (res) => {
        showSuccess('Verificati
      }, (err) => {
        showDanger(err.data.msg || 'Failed to 
        this.countdown = 0;
        this.fetchCaptcha();
      });
    },

    // Reseword logic
    retrievePassword() {
      // Valic
      if (!validateMobile(this.form.mobile, this.form.areaCode)) {
        showDanger('Please enter er');
        return;
      }
      if (!this.form.captcha) {
        showDanger('Please ente');
        return;
      }
      if (!this.form.mobileCaptcha) {
        showDanger('Please ente;
        return;
      }
      if (this.form.newPassword !== this.form.confirmPassword) {
        showDanger('Passwords do 
        return;
      }

      Api.user.retrievePassword({
        phone: this.form.areaCode + this.form.mobile,
        password: this.form.newPassword,
        code: this.form.mobileCaptcha
      }, (res) => {
        showSuccess('Password sful');
        goToPage('/login');
      }, (err) => {
        showDanger(err.data.msg || 'Reset f;
        if (err.data != null && err.data.msg != null && err.data.msg.indexOf('图形验证码') > -1) {
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