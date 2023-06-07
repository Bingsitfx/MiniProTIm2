"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersAccountModule = void 0;
const common_1 = require("@nestjs/common");
const users_account_service_1 = require("./users_account.service");
const users_account_controller_1 = require("./users_account.controller");
let UsersAccountModule = class UsersAccountModule {
};
UsersAccountModule = __decorate([
    (0, common_1.Module)({
        controllers: [users_account_controller_1.UsersAccountController],
        providers: [users_account_service_1.UsersAccountService]
    })
], UsersAccountModule);
exports.UsersAccountModule = UsersAccountModule;
//# sourceMappingURL=users_account.module.js.map