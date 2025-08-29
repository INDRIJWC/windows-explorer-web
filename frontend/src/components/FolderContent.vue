<template>
  <div>
    <h3>Contents</h3>
    <div class="content-list">
      <div v-for="sf in subfolders" :key="sf.id" class="item">
        <span class="icon">📁</span>
        <span>{{ sf.name }}</span>
      </div>
      <div v-for="file in files" :key="file.id" class="item">
        <span class="icon">📄</span>
        <span>{{ file.name }}</span>
        <span class="meta">({{ formatSize(file.size_bytes) }})</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{ subfolders: any[], files: any[] }>();

const formatSize = (bytes: number) => {
  if (!bytes) return "0 B";
  const sizes = ["B", "KB", "MB", "GB"];
  const i = Math.floor(Math.log(bytes) / Math.log(1024));
  return (bytes / Math.pow(1024, i)).toFixed(1) + " " + sizes[i];
};
</script>

<style>
.content-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}
.item {
  width: 120px;
  padding: 5px;
  text-align: center;
  cursor: default;
  border-radius: 4px;
}
.item:hover {
  background: #333;
}
.icon {
  display: block;
  font-size: 32px;
  margin-bottom: 4px;
}
.meta {
  display: block;
  font-size: 11px;
  color: #aaa;
}
</style>
