<template>
  <ul class="tree">
    <li v-for="f in folders" :key="f.id">
      <div class="folder-row" @click="$emit('select', f.id)">
        <span
          v-if="hasChildren(f.id)"
          class="toggle"
          @click.stop="toggleFolder(f.id)"
        >
          {{ isOpen(f.id) ? "▼" : "▶" }}
        </span>
        <span v-else class="toggle">•</span>

        <span class="icon">{{ isOpen(f.id) ? "📂" : "📁" }}</span>
        <span class="folder-name">{{ f.name }}</span>
      </div>

      <FolderTree
        v-if="isOpen(f.id)"
        :folders="childrenOf(f.id)"
        @select="$emit('select', $event)"
      />
    </li>
  </ul>
</template>

<script setup lang="ts">
import { ref } from "vue";

defineProps<{ folders: any[] }>();
defineEmits(["select"]);

const openFolders = ref<Set<number>>(new Set());

const allFolders = ref<any[]>([]);
if (allFolders.value.length === 0) {
  fetch("http://localhost:3000/api/folders")
    .then(res => res.json())
    .then(data => (allFolders.value = data));
}

const hasChildren = (id: number) => {
  return allFolders.value.some(f => f.parent_id === id);
};

const childrenOf = (id: number) => {
  return allFolders.value.filter(f => f.parent_id === id);
};

const toggleFolder = (id: number) => {
  if (openFolders.value.has(id)) openFolders.value.delete(id);
  else openFolders.value.add(id);
};

const isOpen = (id: number) => openFolders.value.has(id);
</script>

<style>
.tree {
  list-style: none;
  padding-left: 1rem;
  margin: 0;
}
.folder-row {
  display: flex;
  align-items: center;
  padding: 2px 0;
  cursor: pointer;
}
.folder-row:hover {
  background: #333;
}
.toggle {
  width: 1rem;
  text-align: center;
  cursor: pointer;
}
.icon {
  margin-right: 5px;
}
.folder-name {
  flex: 1;
}
</style>
