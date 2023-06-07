"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.JobhireService = void 0;
const common_1 = require("@nestjs/common");
let JobhireService = class JobhireService {
    create(createJobhireDto) {
        return 'This action adds a new jobhire';
    }
    findAll() {
        return `This action returns all jobhire`;
    }
    findOne(id) {
        return `This action returns a #${id} jobhire`;
    }
    update(id, updateJobhireDto) {
        return `This action updates a #${id} jobhire`;
    }
    remove(id) {
        return `This action removes a #${id} jobhire`;
    }
};
JobhireService = __decorate([
    (0, common_1.Injectable)()
], JobhireService);
exports.JobhireService = JobhireService;
//# sourceMappingURL=jobhire.service.js.map