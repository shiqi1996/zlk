import request from '@/utils/request'

// 管理员列表
export function getAdminList(params) {
  return request({
    url: '/api/admin/admin/list',
    method: 'get',
    params
  })
}

// 管理员详情
export function getAdminDetail(id) {
  return request({
    url: '/api/admin/admin/detail',
    method: 'get',
    params: { id }
  })
}

// 保存管理员
export function saveAdmin(data) {
  return request({
    url: '/api/admin/admin/save',
    method: 'post',
    data
  })
}

// 删除管理员
export function deleteAdmin(id) {
  return request({
    url: '/api/admin/admin/delete',
    method: 'post',
    data: { id }
  })
}

// 重置密码
export function resetPassword(id, newPassword) {
  return request({
    url: '/api/admin/admin/resetPassword',
    method: 'post',
    data: { id, new_password: newPassword }
  })
}
