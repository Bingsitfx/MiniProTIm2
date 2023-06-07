"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const users_module_1 = require("./users/users.module");
const master_module_1 = require("./master/master.module");
const hr_module_1 = require("./hr/hr.module");
const curriculum_module_1 = require("./curriculum/curriculum.module");
const bootcamp_module_1 = require("./bootcamp/bootcamp.module");
const jobhire_module_1 = require("./jobhire/jobhire.module");
const sales_module_1 = require("./sales/sales.module");
const payment_module_1 = require("./payment/payment.module");
let AppModule = class AppModule {
};
AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            users_module_1.UsersModule,
            master_module_1.MasterModule,
            hr_module_1.HrModule,
            curriculum_module_1.CurriculumModule,
            bootcamp_module_1.BootcampModule,
            jobhire_module_1.JobhireModule,
            sales_module_1.SalesModule,
            payment_module_1.PaymentModule
        ],
        controllers: [],
        providers: [],
    })
], AppModule);
exports.AppModule = AppModule;
//# sourceMappingURL=app.module.js.map