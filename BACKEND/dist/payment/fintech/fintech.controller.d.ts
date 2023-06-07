import { FintechService } from './fintech.service';
import { CreateFintechDto } from './dto/create-fintech.dto';
import { UpdateFintechDto } from './dto/update-fintech.dto';
export declare class FintechController {
    private readonly fintechService;
    constructor(fintechService: FintechService);
    create(createFintechDto: CreateFintechDto): Promise<any>;
    findAll(): Promise<{
        message: string;
        data: unknown[];
    } | {
        message: any;
        status: number;
    }>;
    findOne(id: string): Promise<any>;
    update(id: string, updateFintechDto: UpdateFintechDto): Promise<any>;
    remove(id: string): Promise<any>;
}
