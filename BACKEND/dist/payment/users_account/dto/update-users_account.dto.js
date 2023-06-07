"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateUsersAccountDto = void 0;
const mapped_types_1 = require("@nestjs/mapped-types");
const create_users_account_dto_1 = require("./create-users_account.dto");
class UpdateUsersAccountDto extends (0, mapped_types_1.PartialType)(create_users_account_dto_1.CreateUsersAccountDto) {
}
exports.UpdateUsersAccountDto = UpdateUsersAccountDto;
//# sourceMappingURL=update-users_account.dto.js.map