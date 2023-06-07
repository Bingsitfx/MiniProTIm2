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
exports.UsersAccountController = void 0;
const common_1 = require("@nestjs/common");
const users_account_service_1 = require("./users_account.service");
const create_users_account_dto_1 = require("./dto/create-users_account.dto");
const update_users_account_dto_1 = require("./dto/update-users_account.dto");
let UsersAccountController = class UsersAccountController {
    constructor(usersAccountService) {
        this.usersAccountService = usersAccountService;
    }
    create(createUsersAccountDto) {
        return this.usersAccountService.create(createUsersAccountDto);
    }
    findAll() {
        return this.usersAccountService.findAll();
    }
    findOne(id) {
        return this.usersAccountService.findOne(+id);
    }
    update(id, updateUsersAccountDto) {
        return this.usersAccountService.update(+id, updateUsersAccountDto);
    }
    remove(id) {
        return this.usersAccountService.remove(+id);
    }
};
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_users_account_dto_1.CreateUsersAccountDto]),
    __metadata("design:returntype", void 0)
], UsersAccountController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], UsersAccountController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], UsersAccountController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_users_account_dto_1.UpdateUsersAccountDto]),
    __metadata("design:returntype", void 0)
], UsersAccountController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], UsersAccountController.prototype, "remove", null);
UsersAccountController = __decorate([
    (0, common_1.Controller)('users-account'),
    __metadata("design:paramtypes", [users_account_service_1.UsersAccountService])
], UsersAccountController);
exports.UsersAccountController = UsersAccountController;
//# sourceMappingURL=users_account.controller.js.map