import { Elysia } from "elysia";
import { cors } from "@elysiajs/cors";
import { db } from "./db";

const app = new Elysia()
  .use(cors())   // <- aktifkan CORS
  .get("/api/folders", async () => {
    const { rows } = await db.query("SELECT * FROM folder ORDER BY id");
    return rows;
  })
  .get("/api/folders/:id/subfolders", async ({ params }) => {
    const { rows } = await db.query(
      "SELECT * FROM folder WHERE parent_id = $1 ORDER BY id",
      [params.id]
    );
    return rows;
  })
  .get("/api/folders/:id/files", async ({ params }) => {
    const { rows } = await db.query(
      "SELECT * FROM file_item WHERE folder_id = $1 ORDER BY id",
      [params.id]
    );
    return rows;
  })
  .listen(3000);

console.log("🚀 Backend running at http://localhost:3000");
