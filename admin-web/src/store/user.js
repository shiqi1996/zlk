import { defineStore } from 'pinia'
import { login as loginApi, getUserInfo } from '@/api/auth'
import { getToken, setToken, removeToken } from '@/utils/auth'

export const useUserStore = defineStore('user', {
  state: () => ({
    token: getToken(),
    userInfo: null,
    permissions: []
  }),
  
  actions: {
    // 登录
    async login(loginForm) {
      try {
        const res = await loginApi(loginForm)
        if (res.code === 0) {
          this.token = res.data.token
          setToken(res.data.token)
          this.userInfo = res.data
          return res
        } else {
          throw new Error(res.msg || '登录失败')
        }
      } catch (error) {
        removeToken()
        throw error
      }
    },
    
    // 获取用户信息
    async getInfo() {
      try {
        const res = await getUserInfo()
        if (res.code === 0) {
          this.userInfo = res.data
          this.permissions = res.data.permissions || []
          return res.data
        } else {
          throw new Error(res.msg || '获取用户信息失败')
        }
      } catch (error) {
        this.resetToken()
        throw error
      }
    },
    
    // 退出登录
    async logout() {
      this.token = ''
      this.userInfo = null
      this.permissions = []
      removeToken()
    },
    
    // 重置Token
    resetToken() {
      this.token = ''
      this.userInfo = null
      this.permissions = []
      removeToken()
    }
  }
})
