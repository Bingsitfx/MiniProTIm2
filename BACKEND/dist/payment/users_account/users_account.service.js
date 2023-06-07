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
exports.UsersAccountService = void 0;
const common_1 = require("@nestjs/common");
const sequelize_typescript_1 = require("sequelize-typescript");
let UsersAccountService = class UsersAccountService {
    constructor(sequelize) {
        this.sequelize = sequelize;
    }
    create(createUsersAccountDto) {
        return 'This action adds a new usersAccount';
    }
    findAll() {
        return `This action returns all usersAccount`;
    }
    findOne(id) {
        return `This action returns a #${id} usersAccount`;
    }
    update(id, updateUsersAccountDto) {
        return `This action updates a #${id} usersAccount`;
    }
    remove(id) {
        return `This action removes a #${id} usersAccount`;
    }
};
UsersAccountService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [sequelize_typescript_1.Sequelize])
], UsersAccountService);
exports.UsersAccountService = UsersAccountService;
//# sourceMappingURL=users_account.service.js.map