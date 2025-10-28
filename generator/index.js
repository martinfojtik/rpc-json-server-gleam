// import { OpenrpcDocument } from "@open-rpc/meta-schema";
import MethodTypings from "@open-rpc/typings";
import { parseOpenRPCDocument } from "@open-rpc/schema-utils-js";
import schema from '../schema/api.json' with { type: "json" };

const OpenRPCTypings = MethodTypings.default

const document = await parseOpenRPCDocument(schema)
const typings = new OpenRPCTypings(document);
console.log(typings);
// await typings.generate();
const tsTypings = typings.toString("typescript");

console.log(tsTypings);