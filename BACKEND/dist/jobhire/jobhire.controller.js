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
exports.JobhireController = void 0;
const common_1 = require("@nestjs/common");
const jobhire_service_1 = require("./jobhire.service");
const create_jobhire_dto_1 = require("./dto/create-jobhire.dto");
const update_jobhire_dto_1 = require("./dto/update-jobhire.dto");
let JobhireController = class JobhireController {
    constructor(jobhireService) {
        this.jobhireService = jobhireService;
    }
    create(createJobhireDto) {
        return this.jobhireService.create(createJobhireDto);
    }
    findAll() {
        return this.jobhireService.findAll();
    }
    findOne(id) {
        return this.jobhireService.findOne(+id);
    }
    update(id, updateJobhireDto) {
        return this.jobhireService.update(+id, updateJobhireDto);
    }
    remove(id) {
        return this.jobhireService.remove(+id);
    }
};
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_jobhire_dto_1.CreateJobhireDto]),
    __metadata("design:returntype", void 0)
], JobhireController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], JobhireController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], JobhireController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_jobhire_dto_1.UpdateJobhireDto]),
    __metadata("design:returntype", void 0)
], JobhireController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], JobhireController.prototype, "remove", null);
JobhireController = __decorate([
    (0, common_1.Controller)('jobhire'),
    __metadata("design:paramtypes", [jobhire_service_1.JobhireService])
], JobhireController);
exports.JobhireController = JobhireController;
//# sourceMappingURL=jobhire.controller.js.map