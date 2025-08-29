import pkg from "pg";
const { Pool } = pkg;

export const db = new Pool({
  user: "root",
  host: "localhost",
  database: "windows_explore",
  password: "root",  // ganti sesuai password
  port: 5432,
});
