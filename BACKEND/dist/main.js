"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const core_1 = require("@nestjs/core");
const app_module_1 = require("./app.module");
async function bootstrap() {
    const app = await core_1.NestFactory.create(app_module_1.AppModule);
    const port = process.env.PORT;
    await app.listen(port, () => {
        console.log(`server is listening on port ${port}`);
    });
}
bootstrap();
//# sourceMappingURL=main.js.map