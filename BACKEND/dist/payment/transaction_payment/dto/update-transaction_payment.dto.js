"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateTransactionPaymentDto = void 0;
const mapped_types_1 = require("@nestjs/mapped-types");
const create_transaction_payment_dto_1 = require("./create-transaction_payment.dto");
class UpdateTransactionPaymentDto extends (0, mapped_types_1.PartialType)(create_transaction_payment_dto_1.CreateTransactionPaymentDto) {
}
exports.UpdateTransactionPaymentDto = UpdateTransactionPaymentDto;
//# sourceMappingURL=update-transaction_payment.dto.js.map