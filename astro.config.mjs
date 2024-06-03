import { defineConfig } from "astro/config";

export default defineConfig({
    site: "https://www.keyflow.systems",
    publicDir: "./static",
    outDir: "./www",
    vite: {
        server: {
            host: "0.0.0.0",
            port: 8443,
            https: {
                cert: "./certs/cert.crt",
                key: "./certs/cert.key"
            }
        }
    }
});