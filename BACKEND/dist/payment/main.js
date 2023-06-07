"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const core_1 = require("@nestjs/core");
const payment_module_1 = require("./payment.module");
const common_1 = require("@nestjs/common");
async function bootstrap() {
    const app = await core_1.NestFactory.create(payment_module_1.PaymentModule);
    const port = process.env.PORT || 5000;
    app.enableCors();
    app.useGlobalPipes(new common_1.ValidationPipe());
    await app.listen(port, () => {
        console.log(`Server started on port ${port}`);
    });
}
bootstrap();
//# sourceMappingURL=main.js.map