import { JobhireService } from './jobhire.service';
import { CreateJobhireDto } from './dto/create-jobhire.dto';
import { UpdateJobhireDto } from './dto/update-jobhire.dto';
export declare class JobhireController {
    private readonly jobhireService;
    constructor(jobhireService: JobhireService);
    create(createJobhireDto: CreateJobhireDto): string;
    findAll(): string;
    findOne(id: string): string;
    update(id: string, updateJobhireDto: UpdateJobhireDto): string;
    remove(id: string): string;
}
