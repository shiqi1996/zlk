<template>
  <div class="site-manage">
    <el-card shadow="never">
      <template #header>
        <div class="card-header">
          <span>分站管理</span>
          <el-button type="primary" @click="handleAdd">新增分站</el-button>
        </div>
      </template>
      
      <el-table :data="tableData" border stripe>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="site_name" label="分站名称" />
        <el-table-column prop="site_code" label="分站编码" />
        <el-table-column prop="domain" label="绑定域名" />
        <el-table-column prop="level" label="等级" width="100" />
        <el-table-column prop="expire_time" label="到期时间" width="180" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '正常' : '停用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template #default="{ row }">
            <el-button type="primary" link @click="handleEdit(row)">编辑</el-button>
            <el-button type="danger" link @click="handleDelete(row)">删除</el-button>
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
  { id: 1, site_name: '主站', site_code: 'main', domain: 'zlk.com', level: 1, expire_time: '2027-01-01', status: 1 }
])

const handleAdd = () => {
  ElMessage.info('分站管理功能开发中')
}

const handleEdit = (row) => {
  ElMessage.info('分站编辑功能开发中')
}

const handleDelete = (row) => {
  ElMessage.info('分站删除功能开发中')
}
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
