import { Preferences } from 'nativescript-preferences';
import accessorBuilder from './default-cred-accessor';

const accessor = accessorBuilder(new Preferences());
export default accessor;

export { LocalCredentialAccessor } from './types';