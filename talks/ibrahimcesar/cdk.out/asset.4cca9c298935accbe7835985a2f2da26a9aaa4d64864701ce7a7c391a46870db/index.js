var __defProp = Object.defineProperty;
var __markAsModule = (target) => __defProp(target, "__esModule", { value: true });
var __export = (target, all) => {
  __markAsModule(target);
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};

// api/lambda/index.ts
__export(exports, {
  ApiLambda: () => handler
});

// api/config.json
var apiName = "DevOpsExtreme";
var apiDescription = "General purpose Lambda to get request from API Gateway with CDK";
var api = {
  handler: "ApiLambda"
};
var headers = {
  "Content-Type": "text/plain;charset=utf-8",
  "X-Clacks-Overhead": "GNU Terry Pratchett"
};
var tags = [
  { key: "Key", value: "Value" },
  { key: "Project", value: "ServerlessLand" }
];
var config_default = {
  apiName,
  apiDescription,
  api,
  headers,
  tags
};

// api/lambda/api.ts
var handler = async (event) => {
  return {
    body: `Ol\xE1 DevOpsExtreme, Fora Bolsonaro: "${event.path}"`,
    headers: config_default.headers,
    statusCode: 200
  };
};
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  ApiLambda
});
//# sourceMappingURL=index.js.map
