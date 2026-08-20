import request from '@/utils/request'

// 登录
export function login(data) {
  return request({
    url: '/api/admin/auth/login',
    method: 'post',
    data
  })
}

// 获取用户信息
export function getUserInfo() {
  return request({
    url: '/api/admin/auth/info',
    method: 'get'
  })
}

// 退出登录
export function logout() {
  return request({
    url: '/api/admin/auth/logout',
    method: 'post'
  })
}
