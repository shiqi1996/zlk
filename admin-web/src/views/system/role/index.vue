<template>
  <div class="role-manage">
    <el-card shadow="never">
      <template #header>
        <div class="card-header">
          <span>角色权限管理</span>
          <el-button type="primary" @click="handleAdd">新增角色</el-button>
        </div>
      </template>
      
      <el-table :data="tableData" border stripe>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="role_name" label="角色名称" />
        <el-table-column prop="role_code" label="角色编码" />
        <el-table-column prop="description" label="描述" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '正常' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template #default="{ row }">
            <el-button type="primary" link @click="handleEdit(row)">编辑</el-button>
            <el-button type="primary" link @click="handlePermission(row)">权限配置</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'

const tableData = ref([
  { id: 1, role_name: '超级管理员', role_code: 'super_admin', description: '拥有所有权限', status: 1 },
  { id: 2, role_name: '运营岗', role_code: 'operator', description: '负责日常运营', status: 1 },
  { id: 3, role_name: '审核岗', role_code: 'auditor', description: '负责资料审核', status: 1 },
  { id: 4, role_name: '财务岗', role_code: 'finance', description: '负责财务管理', status: 1 }
])

const handleAdd = () => {
  ElMessage.info('角色管理功能开发中')
}

const handleEdit = (row) => {
  ElMessage.info('角色编辑功能开发中')
}

const handlePermission = (row) => {
  ElMessage.info('权限配置功能开发中')
}
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
