import { defineConfig } from "astro/config";

export default defineConfig({
    site: "https://www.keyflow.systems",
    publicDir: "./static",
    outDir: "./www",
    vite: {
        server: {
            https: {
                cert: "./certs/cert.crt",
                key: "./certs/cert.key"
            }
        }
    }
});