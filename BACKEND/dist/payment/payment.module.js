"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PaymentModule = void 0;
const common_1 = require("@nestjs/common");
const payment_controller_1 = require("./payment.controller");
const sequelize_1 = require("@nestjs/sequelize");
const payment_service_1 = require("./payment.service");
const bank_module_1 = require("./bank/bank.module");
const fintech_module_1 = require("./fintech/fintech.module");
const transaction_payment_module_1 = require("./transaction_payment/transaction_payment.module");
const users_account_module_1 = require("./users_account/users_account.module");
let PaymentModule = class PaymentModule {
};
PaymentModule = __decorate([
    (0, common_1.Module)({
        imports: [
            sequelize_1.SequelizeModule.forRootAsync({
                useFactory: () => ({
                    dialect: 'postgres',
                    host: 'localhost',
                    port: 5432,
                    username: 'postgres',
                    password: '9005',
                    database: 'MinPro',
                    models: [],
                    autoLoadModels: true,
                }),
            }),
            bank_module_1.BankModule,
            fintech_module_1.FintechModule,
            transaction_payment_module_1.TransactionPaymentModule,
            users_account_module_1.UsersAccountModule,
        ],
        controllers: [payment_controller_1.AppController],
        providers: [payment_service_1.AppService],
    })
], PaymentModule);
exports.PaymentModule = PaymentModule;
//# sourceMappingURL=payment.module.js.map