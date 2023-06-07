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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TransactionPaymentController = void 0;
const common_1 = require("@nestjs/common");
const transaction_payment_service_1 = require("./transaction_payment.service");
const create_transaction_payment_dto_1 = require("./dto/create-transaction_payment.dto");
const update_transaction_payment_dto_1 = require("./dto/update-transaction_payment.dto");
let TransactionPaymentController = class TransactionPaymentController {
    constructor(transactionPaymentService) {
        this.transactionPaymentService = transactionPaymentService;
    }
    create(createTransactionPaymentDto) {
        return this.transactionPaymentService.create(createTransactionPaymentDto);
    }
    findAll() {
        return this.transactionPaymentService.findAll();
    }
    findOne(id) {
        return this.transactionPaymentService.findOne(+id);
    }
    update(id, updateTransactionPaymentDto) {
        return this.transactionPaymentService.update(+id, updateTransactionPaymentDto);
    }
    remove(id) {
        return this.transactionPaymentService.remove(+id);
    }
};
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_transaction_payment_dto_1.CreateTransactionPaymentDto]),
    __metadata("design:returntype", void 0)
], TransactionPaymentController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], TransactionPaymentController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], TransactionPaymentController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_transaction_payment_dto_1.UpdateTransactionPaymentDto]),
    __metadata("design:returntype", void 0)
], TransactionPaymentController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], TransactionPaymentController.prototype, "remove", null);
TransactionPaymentController = __decorate([
    (0, common_1.Controller)('transaction-payment'),
    __metadata("design:paramtypes", [transaction_payment_service_1.TransactionPaymentService])
], TransactionPaymentController);
exports.TransactionPaymentController = TransactionPaymentController;
//# sourceMappingURL=transaction_payment.controller.js.map