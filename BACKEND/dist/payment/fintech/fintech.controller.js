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
exports.FintechController = void 0;
const common_1 = require("@nestjs/common");
const fintech_service_1 = require("./fintech.service");
const create_fintech_dto_1 = require("./dto/create-fintech.dto");
const update_fintech_dto_1 = require("./dto/update-fintech.dto");
let FintechController = class FintechController {
    constructor(fintechService) {
        this.fintechService = fintechService;
    }
    create(createFintechDto) {
        return this.fintechService.createFintech(createFintechDto);
    }
    findAll() {
        return this.fintechService.findAllFintech();
    }
    findOne(id) {
        return this.fintechService.findOneFintech(+id);
    }
    update(id, updateFintechDto) {
        return this.fintechService.updateFintech(+id, updateFintechDto);
    }
    remove(id) {
        return this.fintechService.deleteFintech(+id);
    }
};
__decorate([
    (0, common_1.Post)('Create'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_fintech_dto_1.CreateFintechDto]),
    __metadata("design:returntype", void 0)
], FintechController.prototype, "create", null);
__decorate([
    (0, common_1.Get)('All'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], FintechController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)('One/:id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], FintechController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)('Update/:id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_fintech_dto_1.UpdateFintechDto]),
    __metadata("design:returntype", void 0)
], FintechController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)('Delete/:id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], FintechController.prototype, "remove", null);
FintechController = __decorate([
    (0, common_1.Controller)('fintech'),
    __metadata("design:paramtypes", [fintech_service_1.FintechService])
], FintechController);
exports.FintechController = FintechController;
//# sourceMappingURL=fintech.controller.js.map