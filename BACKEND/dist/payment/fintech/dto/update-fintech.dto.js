"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateFintechDto = void 0;
const mapped_types_1 = require("@nestjs/mapped-types");
const create_fintech_dto_1 = require("./create-fintech.dto");
class UpdateFintechDto extends (0, mapped_types_1.PartialType)(create_fintech_dto_1.CreateFintechDto) {
}
exports.UpdateFintechDto = UpdateFintechDto;
//# sourceMappingURL=update-fintech.dto.js.map