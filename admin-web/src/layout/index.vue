<template>
  <el-container class="layout-container">
    <!-- 侧边栏 -->
    <el-aside :width="isCollapse ? '64px' : '210px'" class="sidebar">
      <div class="logo">
        <img src="@/assets/logo.png" alt="Logo" v-if="!isCollapse" />
        <span v-if="!isCollapse">模特库后台</span>
        <el-icon v-else><OfficeBuilding /></el-icon>
      </div>
      
      <el-menu
        :default-active="activeMenu"
        :collapse="isCollapse"
        :unique-opened="true"
        router
        background-color="#304156"
        text-color="#bfcbd9"
        active-text-color="#409EFF"
      >
        <template v-for="route in menuRoutes" :key="route.path">
          <!-- 单级菜单 -->
          <el-menu-item
            v-if="!route.children || route.children.length === 1"
            :index="getMenuPath(route)"
          >
            <el-icon v-if="getMenuIcon(route)">
              <component :is="getMenuIcon(route)" />
            </el-icon>
            <template #title>{{ getMenuTitle(route) }}</template>
          </el-menu-item>
          
          <!-- 多级菜单 -->
          <el-sub-menu v-else :index="route.path">
            <template #title>
              <el-icon v-if="route.meta?.icon">
                <component :is="route.meta.icon" />
              </el-icon>
              <span>{{ route.meta?.title }}</span>
            </template>
            <el-menu-item
              v-for="child in route.children"
              :key="child.path"
              :index="`${route.path}/${child.path}`"
            >
              <el-icon v-if="child.meta?.icon">
                <component :is="child.meta.icon" />
              </el-icon>
              <template #title>{{ child.meta?.title }}</template>
            </el-menu-item>
          </el-sub-menu>
        </template>
      </el-menu>
    </el-aside>
    
    <!-- 主内容区 -->
    <el-container>
      <!-- 顶部导航 -->
      <el-header class="header">
        <div class="header-left">
          <el-icon class="collapse-btn" @click="toggleCollapse">
            <Fold v-if="!isCollapse" />
            <Expand v-else />
          </el-icon>
        </div>
        
        <div class="header-right">
          <el-dropdown @command="handleCommand">
            <span class="user-info">
              <el-avatar :size="32" :src="userStore.userInfo?.avatar">
                {{ userStore.userInfo?.real_name?.charAt(0) }}
              </el-avatar>
              <span class="username">{{ userStore.userInfo?.real_name }}</span>
              <el-icon><ArrowDown /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="profile">个人中心</el-dropdown-item>
                <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </el-header>
      
      <!-- 内容区 -->
      <el-main class="main-content">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessageBox, ElMessage } from 'element-plus'
import { useUserStore } from '@/store/user'
import {
  OfficeBuilding, Fold, Expand, ArrowDown
} from '@element-plus/icons-vue'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const isCollapse = ref(false)

// 获取需要显示的路由（排除登录页等）
const menuRoutes = computed(() => {
  return router.options.routes.filter(r => r.path !== '/login')
})

// 当前激活的菜单
const activeMenu = computed(() => {
  return route.path
})

// 获取菜单路径
const getMenuPath = (route) => {
  if (route.children && route.children.length === 1) {
    return `${route.path}/${route.children[0].path}`
  }
  return route.path
}

// 获取菜单标题
const getMenuTitle = (route) => {
  if (route.children && route.children.length === 1) {
    return route.children[0].meta?.title
  }
  return route.meta?.title
}

// 获取菜单图标
const getMenuIcon = (route) => {
  if (route.children && route.children.length === 1) {
    return route.children[0].meta?.icon
  }
  return route.meta?.icon
}

// 切换折叠
const toggleCollapse = () => {
  isCollapse.value = !isCollapse.value
}

// 处理下拉命令
const handleCommand = async (command) => {
  if (command === 'logout') {
    try {
      await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
      await userStore.logout()
      ElMessage.success('已退出登录')
      router.push('/login')
    } catch {
      // 用户取消
    }
  } else if (command === 'profile') {
    ElMessage.info('个人中心功能开发中')
  }
}
</script>

<style lang="scss" scoped>
.layout-container {
  height: 100vh;
  
  .sidebar {
    background-color: #304156;
    transition: width 0.3s;
    
    .logo {
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
      font-size: 18px;
      font-weight: 600;
      border-bottom: 1px solid #1f2d3d;
      
      img {
        width: 32px;
        height: 32px;
        margin-right: 10px;
      }
    }
    
    :deep(.el-menu) {
      border-right: none;
    }
  }
  
  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: #fff;
    box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
    
    .header-left {
      .collapse-btn {
        font-size: 20px;
        cursor: pointer;
        color: #5a5e66;
        
        &:hover {
          color: #409EFF;
        }
      }
    }
    
    .header-right {
      .user-info {
        display: flex;
        align-items: center;
        cursor: pointer;
        
        .username {
          margin: 0 8px;
          font-size: 14px;
          color: #5a5e66;
        }
      }
    }
  }
  
  .main-content {
    background-color: #f0f2f5;
    padding: 20px;
    overflow-y: auto;
  }
}
</style>
