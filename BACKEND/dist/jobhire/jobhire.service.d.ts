import { CreateJobhireDto } from './dto/create-jobhire.dto';
import { UpdateJobhireDto } from './dto/update-jobhire.dto';
export declare class JobhireService {
    create(createJobhireDto: CreateJobhireDto): string;
    findAll(): string;
    findOne(id: number): string;
    update(id: number, updateJobhireDto: UpdateJobhireDto): string;
    remove(id: number): string;
}
