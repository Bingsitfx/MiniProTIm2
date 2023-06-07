"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TransactionPaymentService = void 0;
const common_1 = require("@nestjs/common");
const sequelize_typescript_1 = require("sequelize-typescript");
let TransactionPaymentService = class TransactionPaymentService {
    constructor(sequelize) {
        this.sequelize = sequelize;
    }
    create(createTransactionPaymentDto) {
        return 'This action adds a new transactionPayment';
    }
    findAll() {
        return `This action returns all transactionPayment`;
    }
    findOne(id) {
        return `This action returns a #${id} transactionPayment`;
    }
    update(id, updateTransactionPaymentDto) {
        return `This action updates a #${id} transactionPayment`;
    }
    remove(id) {
        return `This action removes a #${id} transactionPayment`;
    }
};
TransactionPaymentService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [sequelize_typescript_1.Sequelize])
], TransactionPaymentService);
exports.TransactionPaymentService = TransactionPaymentService;
//# sourceMappingURL=transaction_payment.service.js.map