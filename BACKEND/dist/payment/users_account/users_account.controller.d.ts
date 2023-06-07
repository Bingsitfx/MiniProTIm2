import { UsersAccountService } from './users_account.service';
import { CreateUsersAccountDto } from './dto/create-users_account.dto';
import { UpdateUsersAccountDto } from './dto/update-users_account.dto';
export declare class UsersAccountController {
    private readonly usersAccountService;
    constructor(usersAccountService: UsersAccountService);
    create(createUsersAccountDto: CreateUsersAccountDto): string;
    findAll(): string;
    findOne(id: string): string;
    update(id: string, updateUsersAccountDto: UpdateUsersAccountDto): string;
    remove(id: string): string;
}
