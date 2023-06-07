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
exports.BankService = void 0;
const common_1 = require("@nestjs/common");
const sequelize_typescript_1 = require("sequelize-typescript");
const sequelize_1 = require("sequelize");
let BankService = class BankService {
    constructor(sequelize) {
        this.sequelize = sequelize;
    }
    async createBank(createBankDto) {
        try {
            const [result, _] = await this.sequelize.query('INSERT INTO payment.bank (bank_code, bank_name) VALUES (:bankCode, :bankName)', {
                replacements: {
                    bankCode: createBankDto.bank_code,
                    bankName: createBankDto.bank_name,
                },
            });
            const success = {
                message: 'Sukses membuat Bank',
                status: 200,
                data: result,
            };
            return success;
        }
        catch (error) {
            const errorm = {
                message: error.message,
                status: 400,
            };
            return errorm;
        }
    }
    async findAllBank() {
        try {
            const data = await this.sequelize.query('select * from payment.bank ');
            const success = {
                message: 'sukses',
                data: data[0]
            };
            return success;
        }
        catch (error) {
            const errorm = {
                message: error.message,
                status: 400,
            };
            return errorm;
        }
    }
    async findOneBank(id) {
        try {
            const [data, _] = await this.sequelize.query('SELECT * FROM payment.bank WHERE bank_entity_id = :bank_entity_id', {
                replacements: {
                    bank_entity_id: id,
                },
                type: sequelize_1.QueryTypes.SELECT,
            });
            if (data.length === 0) {
                return {
                    status: 404,
                    message: 'Data bank tidak ditemukan',
                };
            }
            return data;
        }
        catch (error) {
            return {
                status: 400,
                message: error.message,
            };
        }
    }
    async updateBank(id, updateBankDto) {
        try {
            const [result, _] = await this.sequelize.query('UPDATE payment.bank SET bank_code = :bankCode, bank_name = :bankName WHERE bank_entity_id = :bank_entity_id', {
                replacements: {
                    bank_entity_id: id,
                    bankCode: updateBankDto.bank_code,
                    bankName: updateBankDto.bank_name,
                },
            });
            if (result[1] === 0) {
                return {
                    status: 404,
                    message: 'Data bank tidak ditemukan',
                };
            }
            const success = {
                message: 'Sukses mengupdate Bank',
                status: 200,
            };
            return success;
        }
        catch (error) {
            const errorm = {
                message: error.message,
                status: 400,
            };
            return errorm;
        }
    }
    async deleteBank(id) {
        try {
            const result = await this.sequelize.query('DELETE FROM payment.bank WHERE bank_entity_id = :bank_entity_id', {
                replacements: {
                    bank_entity_id: id,
                },
            });
            if (result[1].rowCount === 0) {
                return {
                    status: 404,
                    message: 'Data bank tidak ditemukan',
                };
            }
            return {
                status: 200,
                message: 'Data bank berhasil dihapus',
            };
        }
        catch (error) {
            return {
                status: 400,
                message: error.message,
            };
        }
    }
};
BankService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [sequelize_typescript_1.Sequelize])
], BankService);
exports.BankService = BankService;
//# sourceMappingURL=bank.service.js.map