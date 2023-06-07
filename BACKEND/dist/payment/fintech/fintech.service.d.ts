import { CreateFintechDto } from './dto/create-fintech.dto';
import { UpdateFintechDto } from './dto/update-fintech.dto';
import { Sequelize } from 'sequelize-typescript';
export declare class FintechService {
    private sequelize;
    constructor(sequelize: Sequelize);
    createFintech(CreateFintechDto: CreateFintechDto): Promise<any>;
    findAllFintech(): Promise<{
        message: string;
        data: unknown[];
    } | {
        message: any;
        status: number;
    }>;
    findOneFintech(id: number): Promise<any>;
    updateFintech(id: number, UpdateFintechDto: UpdateFintechDto): Promise<any>;
    deleteFintech(id: number): Promise<any>;
}
