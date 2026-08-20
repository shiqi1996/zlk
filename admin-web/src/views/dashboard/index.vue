<template>
  <div class="dashboard-container">
    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stat-cards">
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-info">
              <div class="stat-title">今日新增会员</div>
              <div class="stat-value">{{ stats.todayMembers }}</div>
            </div>
            <el-icon class="stat-icon" style="color: #409EFF;"><User /></el-icon>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-info">
              <div class="stat-title">待审核资料</div>
              <div class="stat-value">{{ stats.pendingProfiles }}</div>
            </div>
            <el-icon class="stat-icon" style="color: #67C23A;"><Document /></el-icon>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-info">
              <div class="stat-title">今日收入</div>
              <div class="stat-value">¥{{ stats.todayIncome }}</div>
            </div>
            <el-icon class="stat-icon" style="color: #E6A23C;"><Money /></el-icon>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-info">
              <div class="stat-title">待处理事项</div>
              <div class="stat-value">{{ stats.pendingTasks }}</div>
            </div>
            <el-icon class="stat-icon" style="color: #F56C6C;"><Bell /></el-icon>
          </div>
        </el-card>
      </el-col>
    </el-row>
    
    <!-- 图表区域 -->
    <el-row :gutter="20" class="chart-row">
      <el-col :span="16">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>会员增长趋势</span>
            </div>
          </template>
          <div ref="memberChartRef" class="chart-container"></div>
        </el-card>
      </el-col>
      
      <el-col :span="8">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>待办事项</span>
            </div>
          </template>
          <el-timeline>
            <el-timeline-item
              v-for="(item, index) in todoList"
              :key="index"
              :type="item.type"
              :timestamp="item.time"
            >
              {{ item.content }}
            </el-timeline-item>
          </el-timeline>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import * as echarts from 'echarts'
import { User, Document, Money, Bell } from '@element-plus/icons-vue'

const memberChartRef = ref(null)

const stats = reactive({
  todayMembers: 128,
  pendingProfiles: 45,
  todayIncome: '12,580',
  pendingTasks: 23
})

const todoList = reactive([
  { content: '3位模特资料待审核', type: 'warning', time: '10分钟前' },
  { content: '2笔验资申请待处理', type: 'primary', time: '30分钟前' },
  { content: '新会员注册审核 5人', type: 'success', time: '1小时前' },
  { content: '系统备份已完成', type: 'info', time: '2小时前' }
])

onMounted(() => {
  initMemberChart()
})

const initMemberChart = () => {
  if (!memberChartRef.value) return
  
  const chart = echarts.init(memberChartRef.value)
  
  const option = {
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: ['新增会员', '活跃会员']
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        name: '新增会员',
        type: 'line',
        smooth: true,
        data: [120, 132, 101, 134, 90, 230, 210],
        itemStyle: {
          color: '#409EFF'
        },
        areaStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: 'rgba(64, 158, 255, 0.3)' },
            { offset: 1, color: 'rgba(64, 158, 255, 0.05)' }
          ])
        }
      },
      {
        name: '活跃会员',
        type: 'line',
        smooth: true,
        data: [220, 182, 191, 234, 290, 330, 310],
        itemStyle: {
          color: '#67C23A'
        },
        areaStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: 'rgba(103, 194, 58, 0.3)' },
            { offset: 1, color: 'rgba(103, 194, 58, 0.05)' }
          ])
        }
      }
    ]
  }
  
  chart.setOption(option)
  
  window.addEventListener('resize', () => {
    chart.resize()
  })
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  .stat-cards {
    margin-bottom: 20px;
    
    .stat-card {
      .stat-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        
        .stat-info {
          .stat-title {
            font-size: 14px;
            color: #909399;
            margin-bottom: 8px;
          }
          
          .stat-value {
            font-size: 28px;
            font-weight: 600;
            color: #303133;
          }
        }
        
        .stat-icon {
          font-size: 48px;
          opacity: 0.8;
        }
      }
    }
  }
  
  .chart-row {
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-weight: 600;
    }
    
    .chart-container {
      height: 350px;
    }
  }
}
</style>
