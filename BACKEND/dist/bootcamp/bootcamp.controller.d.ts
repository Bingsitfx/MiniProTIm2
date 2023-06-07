import { BootcampService } from './bootcamp.service';
import { CreateBootcampDto } from './dto/create-bootcamp.dto';
import { UpdateBootcampDto } from './dto/update-bootcamp.dto';
export declare class BootcampController {
    private readonly bootcampService;
    constructor(bootcampService: BootcampService);
    create(createBootcampDto: CreateBootcampDto): string;
    findAll(): string;
    findOne(id: string): string;
    update(id: string, updateBootcampDto: UpdateBootcampDto): string;
    remove(id: string): string;
}
