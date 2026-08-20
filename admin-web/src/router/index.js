import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/store/user'

// 公开路由
const publicRoutes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/login/index.vue'),
    meta: { title: '登录' }
  }
]

// 需要认证的路由
const asyncRoutes = [
  {
    path: '/',
    component: () => import('@/layout/index.vue'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        meta: { title: '数据看板', icon: 'Odometer' }
      }
    ]
  },
  {
    path: '/system',
    component: () => import('@/layout/index.vue'),
    meta: { title: '系统管理', icon: 'Setting' },
    children: [
      {
        path: 'site',
        name: 'SiteManage',
        component: () => import('@/views/system/site/index.vue'),
        meta: { title: '分站管理', icon: 'OfficeBuilding' }
      },
      {
        path: 'admin',
        name: 'AdminManage',
        component: () => import('@/views/system/admin/index.vue'),
        meta: { title: '管理员管理', icon: 'User' }
      },
      {
        path: 'role',
        name: 'RoleManage',
        component: () => import('@/views/system/role/index.vue'),
        meta: { title: '角色权限', icon: 'Lock' }
      }
    ]
  },
  {
    path: '/member',
    component: () => import('@/layout/index.vue'),
    meta: { title: '会员管理', icon: 'UserFilled' },
    children: [
      {
        path: 'list',
        name: 'MemberList',
        component: () => import('@/views/member/index.vue'),
        meta: { title: '会员列表', icon: 'List' }
      }
    ]
  },
  {
    path: '/verify',
    component: () => import('@/layout/index.vue'),
    meta: { title: '验资管理', icon: 'DocumentChecked' },
    children: [
      {
        path: 'list',
        name: 'VerifyList',
        component: () => import('@/views/verify/index.vue'),
        meta: { title: '验资列表', icon: 'Tickets' }
      }
    ]
  },
  {
    path: '/model',
    component: () => import('@/layout/index.vue'),
    meta: { title: '模特管理', icon: 'Picture' },
    children: [
      {
        path: 'profile',
        name: 'ModelProfile',
        component: () => import('@/views/model/index.vue'),
        meta: { title: '模特资料', icon: 'Files' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes: [...publicRoutes, ...asyncRoutes]
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const userStore = useUserStore()
  
  // 设置页面标题
  document.title = to.meta.title ? `${to.meta.title} - 模特库后台` : '模特库后台'
  
  // 白名单路由
  const whiteList = ['/login']
  
  if (userStore.token) {
    if (to.path === '/login') {
      next({ path: '/' })
    } else {
      next()
    }
  } else {
    if (whiteList.includes(to.path)) {
      next()
    } else {
      next(`/login?redirect=${to.path}`)
    }
  }
})

export default router
