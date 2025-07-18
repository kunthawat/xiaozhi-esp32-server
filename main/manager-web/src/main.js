import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import 'normalize.css/normalize.css'; // A modern alternative to CSS resets
import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import './styles/global.scss';
import { register as registerServiceWorker } from './registerServiceWorker';

Vue.use(ElementUI);

Vue.config.productionTip = false

// Register Service Worker
registerServiceWorker();

// Create Vue instance
new Vue({
  router,
  store,
  render: function (h) { return h(App) }
}).$mount('#app')
