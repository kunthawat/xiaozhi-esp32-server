<template>
  <el-dialog
    title="CDN Resource Cache Status"
    :visible.sync="visible"
    width="70%"
    :before-close="handleClose"
  >
    <div v-if="isLoading" class="loading-container">
      <p>Loading cache information...</p>
    </div>
    
    <div v-else>
      <div v-if="!cacheAvailable" class="no-cache-message">
        <i class="el-icon-warning-outline"></i>
        <p>Your browser does not support Cache API or Service Worker is not installed</p>
        <el-button type="primary" @click="refreshPage">Refresh Page</el-button>
      </div>
      
      <div v-else>
        <el-alert
          v-if="cacheData.totalCached === 0"
          title="No cached CDN resources found"
          type="warning"
          :closable="false"
          show-icon
        >
          <p>Service Worker may not have completed initialization or cache has not been established. Please refresh the page or try again later.</p>
        </el-alert>
        
        <div v-else>
          <el-alert
            title="CDN Resource Cache Status"
            type="success"
            :closable="false"
            show-icon
          >
            Found {{ cacheData.totalCached }} cached resources
          </el-alert>
          
          <h3>JavaScript Resources ({{ cacheData.js.length }})</h3>
          <el-table :data="cacheData.js" stripe style="width: 100%">
            <el-table-column prop="url" label="URL" width="auto" show-overflow-tooltip />
            <el-table-column prop="cached" label="Status" width="100">
              <template slot-scope="scope">
                <el-tag type="success" v-if="scope.row.cached">Cached</el-tag>
                <el-tag type="danger" v-else>Not Cached</el-tag>
              </template>
            </el-table-column>
          </el-table>
          
          <h3>CSS Resources ({{ cacheData.css.length }})</h3>
          <el-table :data="cacheData.css" stripe style="width: 100%">
            <el-table-column prop="url" label="URL" width="auto" show-overflow-tooltip />
            <el-table-column prop="cached" label="Status" width="100">
              <template slot-scope="scope">
                <el-tag type="success" v-if="scope.row.cached">Cached</el-tag>
                <el-tag type="danger" v-else>Not Cached</el-tag>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>
    </div>
    
    <span slot="footer" class="dialog-footer">
      <el-button @click="handleClose">Close</el-button>
      <el-button type="primary" @click="refreshCache">Refresh Cache Status</el-button>
      <el-button type="danger" @click="clearCache">Clear Cache</el-button>
    </span>
  </el-dialog>
</template>

<script>
import {
  getCacheNames,
  checkCdnCacheStatus,
  clearAllCaches,
  logCacheStatus
} from '../utils/cacheViewer';

export default {
  name: 'CacheViewer',
  props: {
    visible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      isLoading: true,
      cacheAvailable: false,
      cacheData: {
        css: [],
        js: [],
        totalCached: 0,
        totalNotCached: 0
      }
    };
  },
  watch: {
    visible(newVal) {
      if (newVal) {
        this.loadCacheData();
      }
    }
  },
  methods: {
    async loadCacheData() {
      this.isLoading = true;
      
      try {
        // First check if Cache API is supported
        if (!('caches' in window)) {
          this.cacheAvailable = false;
          this.isLoading = false;
          return;
        }
        
        // Check if there is Service Worker cache
        const cacheNames = await getCacheNames();
        this.cacheAvailable = cacheNames.length > 0;
        
        if (this.cacheAvailable) {
          // Get CDN cache status
          this.cacheData = await checkCdnCacheStatus();
          
          // Output complete cache status to console
          await logCacheStatus();
        }
      } catch (error) {
        console.error('Failed to load cache data:', error);
        this.$message.error('Failed to load cache data');
      } finally {
        this.isLoading = false;
      }
    },
    
    async refreshCache() {
      this.loadCacheData();
      this.$message.success('Refreshing cache status');
    },
    
    async clearCache() {
      this.$confirm('Are you sure you want to clear all caches?', 'Warning', {
        confirmButtonText: 'Confirm',
        cancelButtonText: 'Cancel',
        type: 'warning'
      }).then(async () => {
        try {
          const success = await clearAllCaches();
          if (success) {
            this.$message.success('Cache has been cleared');
            await this.loadCacheData();
          } else {
            this.$message.error('Failed to clear cache');
          }
        } catch (error) {
          console.error('Failed to clear cache:', error);
          this.$message.error('Failed to clear cache');
        }
      }).catch(() => {
        this.$message.info('Clearing canceled');
      });
    },
    
    refreshPage() {
      window.location.reload();
    },
    
    handleClose() {
      this.$emit('update:visible', false);
    }
  }
};
</script>

<style scoped>
.loading-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.loading-spinner {
  margin-bottom: 10px;
}

.no-cache-message {
  text-align: center;
  padding: 20px;
}

.no-cache-message i {
  font-size: 48px;
  color: #E6A23C;
  margin-bottom: 10px;
}

h3 {
  margin-top: 20px;
  margin-bottom: 10px;
  font-weight: 500;
}
</style>