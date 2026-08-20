<template>
  <div class="model-manage">
    <el-card shadow="never">
      <template #header>
        <div class="card-header">
          <span>模特资料管理</span>
        </div>
      </template>
      
      <div class="search-bar">
        <el-form :inline="true">
          <el-form-item label="审核状态">
            <el-select placeholder="请选择" clearable>
              <el-option label="待审核" :value="0" />
              <el-option label="已通过" :value="1" />
              <el-option label="已驳回" :value="2" />
            </el-select>
          </el-form-item>
          <el-form-item label="AI评级">
            <el-select placeholder="请选择" clearable>
              <el-option label="S" value="S" />
              <el-option label="A" value="A" />
              <el-option label="B" value="B" />
              <el-option label="C" value="C" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary">搜索</el-button>
          </el-form-item>
        </el-form>
      </div>
      
      <el-table :data="tableData" border stripe>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="stage_name" label="艺名" />
        <el-table-column prop="gender" label="性别">
          <template #default="{ row }">
            {{ row.gender === 1 ? '男' : '女' }}
          </template>
        </el-table-column>
        <el-table-column prop="age" label="年龄" />
        <el-table-column prop="height" label="身高(cm)" />
        <el-table-column prop="city" label="城市" />
        <el-table-column prop="ai_rating" label="AI评级">
          <template #default="{ row }">
            <el-tag :type="getRatingType(row.ai_rating)" v-if="row.ai_rating">
              {{ row.ai_rating }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="audit_status" label="审核状态">
          <template #default="{ row }">
            <el-tag :type="getAuditStatusType(row.audit_status)">
              {{ getAuditStatusText(row.audit_status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template #default="{ row }">
            <el-button type="primary" link>详情</el-button>
            <el-button type="success" link v-if="row.audit_status === 0">通过</el-button>
            <el-button type="danger" link v-if="row.audit_status === 0">驳回</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const tableData = ref([])

const getRatingType = (rating) => {
  const map = { S: 'danger', A: 'warning', B: 'success', C: 'info' }
  return map[rating] || 'info'
}

const getAuditStatusType = (status) => {
  const map = { 0: 'warning', 1: 'success', 2: 'danger' }
  return map[status] || 'info'
}

const getAuditStatusText = (status) => {
  const map = { 0: '待审核', 1: '已通过', 2: '已驳回' }
  return map[status] || '未知'
}
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.search-bar {
  margin-bottom: 20px;
}
</style>
