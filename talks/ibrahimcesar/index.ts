import * as cdk from "@aws-cdk/core";
import { buildSync } from "esbuild";
import { ApiStack } from "./api/index";
import path from "path";
import config from "./api/config.json";

buildSync({
  bundle: true,
  entryPoints: [path.resolve(__dirname, "api", "lambda", "index.ts")],
  external: ["aws-sdk"],
  format: "cjs",
  outfile: path.join(__dirname, "api", "dist", "index.js"),
  platform: "node",
  sourcemap: true,
  target: "node14.2",
});

const app = new cdk.App();
const idStack = config.apiName;
new ApiStack(app, `${idStack}Api`);
