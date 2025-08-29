import { Elysia } from "elysia";
import { db } from "../db";

export default (app: Elysia) =>
  app.group("/api/folders", app =>
    app
      .get("/", async () => {
        const { rows } = await db.query("SELECT * FROM folder ORDER BY id");
        return rows;
      })
      .get("/:id/subfolders", async ({ params }) => {
        const { rows } = await db.query(
          "SELECT * FROM folder WHERE parent_id = $1 ORDER BY id",
          [params.id]
        );
        return rows;
      })
      .get("/:id/files", async ({ params }) => {
        const { rows } = await db.query(
          "SELECT * FROM file_item WHERE folder_id = $1 ORDER BY id",
          [params.id]
        );
        return rows;
      })
  );
