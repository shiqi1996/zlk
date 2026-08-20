<template>
  <div class="member-manage">
    <el-card shadow="never">
      <template #header>
        <div class="card-header">
          <span>会员管理</span>
        </div>
      </template>
      
      <el-tabs v-model="activeTab">
        <el-tab-pane label="全体会员" name="all"></el-tab-pane>
        <el-tab-pane label="客户身份" name="customer"></el-tab-pane>
        <el-tab-pane label="模特身份" name="model"></el-tab-pane>
      </el-tabs>
      
      <div class="search-bar">
        <el-form :inline="true">
          <el-form-item label="手机号">
            <el-input placeholder="请输入手机号" clearable />
          </el-form-item>
          <el-form-item label="VIP状态">
            <el-select placeholder="请选择" clearable>
              <el-option label="普通用户" :value="0" />
              <el-option label="VIP会员" :value="1" />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary">搜索</el-button>
          </el-form-item>
        </el-form>
      </div>
      
      <el-table :data="tableData" border stripe>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="nickname" label="昵称" />
        <el-table-column prop="phone" label="手机号" />
        <el-table-column prop="identity_tags" label="身份" />
        <el-table-column prop="vip_status" label="VIP状态">
          <template #default="{ row }">
            <el-tag :type="row.vip_status === 1 ? 'warning' : 'info'">
              {{ row.vip_status === 1 ? 'VIP' : '普通' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="score" label="积分" />
        <el-table-column prop="create_time" label="注册时间" />
        <el-table-column label="操作" width="150">
          <template #default="{ row }">
            <el-button type="primary" link>详情</el-button>
            <el-button type="danger" link>禁用</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const activeTab = ref('all')
const tableData = ref([])
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
