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
exports.FintechService = void 0;
const common_1 = require("@nestjs/common");
const sequelize_typescript_1 = require("sequelize-typescript");
const sequelize_1 = require("sequelize");
let FintechService = class FintechService {
    constructor(sequelize) {
        this.sequelize = sequelize;
    }
    async createFintech(CreateFintechDto) {
        try {
            const [result, _] = await this.sequelize.query('INSERT INTO payment.fintech (fint_code, fint_name) VALUES (:fint_code, :fint_name)', {
                replacements: {
                    fint_code: CreateFintechDto.fint_code,
                    fint_name: CreateFintechDto.fint_name,
                },
            });
            const success = {
                message: 'Sukses membuat Fintech',
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
    async findAllFintech() {
        try {
            const data = await this.sequelize.query('select * from payment.fintech ');
            const success = {
                message: 'sukses',
                data: data[0],
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
    async findOneFintech(id) {
        try {
            const [data, _] = await this.sequelize.query('SELECT * FROM payment.fintech WHERE fint_entity_id = :fint_entity_id', {
                replacements: {
                    fint_entity_id: id,
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
    async updateFintech(id, UpdateFintechDto) {
        try {
            const [result, _] = await this.sequelize.query('UPDATE payment.fintech SET fint_code = :fintCode, fint_name = :fintName WHERE fint_entity_id = :fint_entity_id', {
                replacements: {
                    fint_entity_id: id,
                    fintCode: UpdateFintechDto.fint_code,
                    fintName: UpdateFintechDto.fint_name,
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
    async deleteFintech(id) {
        try {
            const result = await this.sequelize.query('DELETE FROM payment.fintech WHERE fint_entity_id = :fint_entity_id', {
                replacements: {
                    fint_entity_id: id,
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
FintechService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [sequelize_typescript_1.Sequelize])
], FintechService);
exports.FintechService = FintechService;
//# sourceMappingURL=fintech.service.js.map