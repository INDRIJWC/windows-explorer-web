<template>
  <div class="explorer">
    <!-- Left Panel -->
    <div class="left">
      <h3>Folders</h3>
      <FolderTree :folders="rootFolders" @select="selectFolder" />
    </div>

    <!-- Right Panel -->
    <div class="right">
      <FolderContent
        v-if="selectedFolder !== null"
        :subfolders="subfolders"
        :files="files"
      />
      <div v-else class="empty">
        <p>Select a folder to view its contents</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import FolderTree from "./components/FolderTree.vue";
import FolderContent from "./components/FolderContent.vue";

const rootFolders = ref<any[]>([]);
const subfolders = ref<any[]>([]);
const files = ref<any[]>([]);
const selectedFolder = ref<number | null>(null);

const selectFolder = async (id: number) => {
  selectedFolder.value = id;

  let res = await fetch(`http://localhost:3000/api/folders/${id}/subfolders`);
  subfolders.value = await res.json();

  res = await fetch(`http://localhost:3000/api/folders/${id}/files`);
  files.value = await res.json();
};

onMounted(async () => {
  const res = await fetch("http://localhost:3000/api/folders");
  const all = await res.json();
  rootFolders.value = all.filter((f: any) => f.parent_id === null);
});
</script>

<style>
.explorer {
  display: flex;
  height: 100vh;
  font-family: "Segoe UI", sans-serif;
  font-size: 14px;
  background: #1e1e1e;
  color: #ddd;
}
.left {
  width: 280px;
  border-right: 1px solid #444;
  padding: 10px;
  overflow-y: auto;
  background: #252526;
}
.right {
  flex: 1;
  padding: 10px;
  overflow-y: auto;
  background: #1e1e1e;
}
.empty {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  color: #666;
  font-style: italic;
}
</style>
