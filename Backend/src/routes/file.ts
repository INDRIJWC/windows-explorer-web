import { Elysia } from "elysia";
import { db } from "../db";

export default (app: Elysia) =>
  app.group("/api/files", app =>
    app.get("/", async () => {
      const { rows } = await db.query("SELECT * FROM file_item ORDER BY id");
      return rows;
    })
  );
